import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const ParticleAccelerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    assembled,
    power,
    strength,
  } = data;
  return (
    <Window
      width={350}
      height={185}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item
              label="Состояние"
              buttons={(
                <Button
                  icon={"sync"}
                  content={"Сканировать"}
                  onClick={() => act('scan')} />
              )}>
              <Box color={assembled ? "good" : "bad"}>
                {assembled
                  ? "Готовы - всё на месте"
                  : "Чего-то не хватает"}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Управление ускорителем частиц">
          <LabeledList>
            <LabeledList.Item label="Питание">
              <Button
                icon={power ? 'power-off' : 'times'}
                content={power ? 'Вкл' : 'Выкл'}
                selected={power}
                disabled={!assembled}
                onClick={() => act('power')} />
            </LabeledList.Item>
            <LabeledList.Item label="Сила частиц">
              <Button
                icon="backward"
                disabled={!assembled}
                onClick={() => act('remove_strength')} />
              {' '}
              {String(strength).padStart(1, '0')}
              {' '}
              <Button
                icon="forward"
                disabled={!assembled}
                onClick={() => act('add_strength')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
