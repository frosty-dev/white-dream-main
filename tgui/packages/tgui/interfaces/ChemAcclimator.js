import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const ChemAcclimator = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={320}
      height={271}>
      <Window.Content>
        <Section title="Аклиматор">
          <LabeledList>
            <LabeledList.Item label="Текущая температура">
              {data.chem_temp} K
            </LabeledList.Item>
            <LabeledList.Item label="Целевая температура">
              <NumberInput
                value={data.target_temperature}
                unit="K"
                width="59px"
                minValue={0}
                maxValue={1000}
                step={5}
                stepPixelSize={2}
                onChange={(e, value) => act('set_target_temperature', {
                  temperature: value,
                })} />
            </LabeledList.Item>
            <LabeledList.Item label="Приемлемая темп. разница">
              <NumberInput
                value={data.allowed_temperature_difference}
                unit="K"
                width="59px"
                minValue={1}
                maxValue={data.target_temperature}
                stepPixelSize={2}
                onChange={(e, value) => {
                  act('set_allowed_temperature_difference', {
                    temperature: value,
                  });
                }} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="Статус"
          buttons={(
            <Button
              icon="power-off"
              content={data.enabled ? "Вкл" : "Выкл"}
              selected={data.enabled}
              onClick={() => act('toggle_power')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Объём">
              <NumberInput
                value={data.max_volume}
                unit="е"
                width="50px"
                minValue={data.reagent_volume}
                maxValue={200}
                step={2}
                stepPixelSize={2}
                onChange={(e, value) => act('change_volume', {
                  volume: value,
                })} />
            </LabeledList.Item>
            <LabeledList.Item label="Текущая операция">
              {data.acclimate_state}
            </LabeledList.Item>
            <LabeledList.Item label="Текущее состояние">
              {data.emptying ? 'Опустошение' : 'Заполнение'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
