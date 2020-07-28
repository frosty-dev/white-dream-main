import { map } from 'common/collections';
import { toFixed } from 'common/math';
import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const AtmosControlConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const sensors = data.sensors || [];
  return (
    <Window
      width={500}
      height={315}
      resizable>
      <Window.Content scrollable>
        <Section
          title={!!data.tank && sensors[0]?.long_name}>
          {sensors.map(sensor => {
            const gases = sensor.gases || {};
            return (
              <Section
                key={sensor.id_tag}
                title={!data.tank && sensor.long_name}
                level={2}>
                <LabeledList>
                  <LabeledList.Item label="Давление">
                    {toFixed(sensor.pressure, 2) + ' кПа'}
                  </LabeledList.Item>
                  {!!sensor.temperature && (
                    <LabeledList.Item label="Температура">
                      {toFixed(sensor.temperature, 2) + ' K'}
                    </LabeledList.Item>
                  )}
                  {map((gasPercent, gasId) => (
                    <LabeledList.Item label={gasId}>
                      {toFixed(gasPercent, 2) + '%'}
                    </LabeledList.Item>
                  ))(gases)}
                </LabeledList>
              </Section>
            );
          })}
        </Section>
        {data.tank && (
          <Section
            title="Управление"
            buttons={(
              <Button
                icon="undo"
                content="Переподключить"
                onClick={() => act('reconnect')} />
            )}>
            <LabeledList>
              <LabeledList.Item label="Инжектор">
                <Button
                  icon={data.inputting ? 'power-off' : 'times'}
                  content={data.inputting ? 'Включен' : 'Отключен'}
                  selected={data.inputting}
                  onClick={() => act('input')} />
              </LabeledList.Item>
              <LabeledList.Item label="Скорость ввода">
                <NumberInput
                  value={data.inputRate}
                  unit="Л/с"
                  width="63px"
                  minValue={0}
                  maxValue={200}
                  // This takes an exceptionally long time to update
                  // due to being an async signal
                  suppressFlicker={2000}
                  onChange={(e, value) => act('rate', {
                    rate: value,
                  })} />
              </LabeledList.Item>
              <LabeledList.Item label="Выход">
                <Button
                  icon={data.outputting ? 'power-off' : 'times'}
                  content={data.outputting ? 'Открыт' : 'Закрыт'}
                  selected={data.outputting}
                  onClick={() => act('output')} />
              </LabeledList.Item>
              <LabeledList.Item label="Выходное давление">
                <NumberInput
                  value={parseFloat(data.outputPressure)}
                  unit="кПа"
                  width="75px"
                  minValue={0}
                  maxValue={4500}
                  step={10}
                  // This takes an exceptionally long time to update
                  // due to being an async signal
                  suppressFlicker={2000}
                  onChange={(e, value) => act('pressure', {
                    pressure: value,
                  })} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
