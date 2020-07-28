import { map, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { clamp } from 'common/math';
import { vecLength, vecSubtract } from 'common/vector';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Icon, LabeledList, Section, Table } from '../components';
import { Window } from '../layouts';

const coordsToVec = coords => map(parseFloat)(coords.split(', '));

export const Gps = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    currentArea,
    currentCoords,
    globalmode,
    power,
    tag,
    updating,
  } = data;
  const signals = flow([
    map((signal, index) => {
      // Calculate distance to the target. BYOND distance is capped to 127,
      // that's why we roll our own calculations here.
      const dist = signal.dist && (
        Math.round(vecLength(vecSubtract(
          coordsToVec(currentCoords),
          coordsToVec(signal.coords))))
      );
      return { ...signal, dist, index };
    }),
    sortBy(
      // Signals with distance metric go first
      signal => signal.dist === undefined,
      // Sort alphabetically
      signal => signal.entrytag),
  ])(data.signals || []);
  return (
    <Window
      title="Global Positioning System"
      width={470}
      height={700}
      resizable>
      <Window.Content scrollable>
        <Section
          title="Управление"
          buttons={(
            <Button
              icon="power-off"
              content={power ? "Вкл" : "Выкл"}
              selected={power}
              onClick={() => act('power')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Тэг">
              <Button
                icon="pencil-alt"
                content={tag}
                onClick={() => act('rename')} />
            </LabeledList.Item>
            <LabeledList.Item label="Сканирование">
              <Button
                icon={updating ? "unlock" : "lock"}
                content={updating ? "АВТО" : "ВРУЧНУЮ"}
                color={!updating && "bad"}
                onClick={() => act('updating')} />
            </LabeledList.Item>
            <LabeledList.Item label="Радиус">
              <Button
                icon="sync"
                content={globalmode ? "МАКСИМУМ" : "МЕСТНЫЙ"}
                selected={!globalmode}
                onClick={() => act('globalmode')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!power && (
          <Fragment>
            <Section title="Текущее местоположение">
              <Box fontSize="18px">
                {currentArea} ({currentCoords})
              </Box>
            </Section>
            <Section title="Обнаруженные сигналы">
              <Table>
                <Table.Row bold>
                  <Table.Cell content="Имя" />
                  <Table.Cell collapsing content="Направление" />
                  <Table.Cell collapsing content="Координаты" />
                </Table.Row>
                {signals.map(signal => (
                  <Table.Row
                    key={signal.entrytag + signal.coords + signal.index}
                    className="candystripe">
                    <Table.Cell bold color="label">
                      {signal.entrytag}
                    </Table.Cell>
                    <Table.Cell
                      collapsing
                      opacity={signal.dist !== undefined && (
                        clamp(
                          1.2 / Math.log(Math.E + signal.dist / 20),
                          0.4, 1)
                      )}>
                      {signal.degrees !== undefined && (
                        <Icon
                          mr={1}
                          size={1.2}
                          name="arrow-up"
                          rotation={signal.degrees} />
                      )}
                      {signal.dist !== undefined && (
                        signal.dist + 'м'
                      )}
                    </Table.Cell>
                    <Table.Cell collapsing>
                      {signal.coords}
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </Fragment>
        )}
      </Window.Content>
    </Window>
  );
};
