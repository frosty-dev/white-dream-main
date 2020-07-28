import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Section } from '../components';
import { Window } from '../layouts';

export const AtmosPump = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={335}
      height={115}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Питание">
              <Button
                icon={data.on ? 'power-off' : 'times'}
                content={data.on ? 'Вкл' : 'Выкл'}
                selected={data.on}
                onClick={() => act('power')} />
            </LabeledList.Item>
            {data.max_rate ? (
              <LabeledList.Item label="Скорость передачи">
                <NumberInput
                  animated
                  value={parseFloat(data.rate)}
                  width="63px"
                  unit="Л/с"
                  minValue={0}
                  maxValue={200}
                  onChange={(e, value) => act('rate', {
                    rate: value,
                  })} />
                <Button
                  ml={1}
                  icon="plus"
                  content="Макс"
                  disabled={data.rate === data.max_rate}
                  onClick={() => act('rate', {
                    rate: 'max',
                  })} />
              </LabeledList.Item>
            ) : (
              <LabeledList.Item label="Выходное давление">
                <NumberInput
                  animated
                  value={parseFloat(data.pressure)}
                  unit="кПа"
                  width="63px"
                  minValue={0}
                  maxValue={4500}
                  step={10}
                  onChange={(e, value) => act('pressure', {
                    pressure: value,
                  })} />
                <Button
                  ml={1}
                  icon="plus"
                  content="Макс"
                  disabled={data.pressure === data.max_pressure}
                  onClick={() => act('pressure', {
                    pressure: 'max',
                  })} />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
