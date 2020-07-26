import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, LabeledControls, Box, Knob, Section } from '../components';
import { Window } from '../layouts';

export const BoomBox = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window>
      <Window.Content>
        <Section
          title="Проигрыватель"
          buttons={(
            <Fragment>
              <Button
                icon={data.active ? 'pause' : 'play'}
                content={data.active ? 'СТОП' : 'СТАРТ'}
                disabled={!data.curtrack}
                onClick={() => act('toggle')} />
              <Button
                content="Выбрать трек"
                onClick={() => act('select')} />
            </Fragment>
          )}>

          <LabeledList>
            <LabeledList.Item label="Трек">
              {data.curtrack ? data.curtrack : "Не выбран"}
            </LabeledList.Item>

            {!data.curlenght || (
              <LabeledList.Item label="Длительность">
                {data.curlenght}
              </LabeledList.Item>
            )}

            <LabeledList.Item label="Объемный звук">
              <Button
                content={data.env ? "ВКЛ" : "ВЫКЛ"}
                onClick={() => act('env')} />
            </LabeledList.Item>

          </LabeledList>
        </Section>
        <Section title="Переключатели">
          <LabeledControls justify="center">
            <LabeledControls.Item label="Громкость">
              <Box position="relative">
                <Knob
                  size={3.2}
                  color={data.volume >= 50 ? 'red' : 'green'}
                  value={data.volume}
                  unit="%"
                  minValue={0}
                  maxValue={100}
                  step={1}
                  stepPixelSize={1}
                  onDrag={(e, value) => act('change_volume', {
                    volume: value,
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="-2px"
                  right="-22px"
                  color="transparent"
                  icon="fast-backward"
                  onClick={() => act('change_volume', {
                    volume: 0,
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="16px"
                  right="-22px"
                  color="transparent"
                  icon="fast-forward"
                  onClick={() => act('change_volume', {
                    volume: 100,
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="34px"
                  right="-22px"
                  color="transparent"
                  icon="undo"
                  onClick={() => act('change_volume', {
                    volume: 20,
                  })} />
              </Box>
            </LabeledControls.Item>
          </LabeledControls>
        </Section>
        {!data.disk || (
          <Section title="Диск">

            <LabeledList>
              <LabeledList.Item label="Трек">
                {data.disktrack ? data.disktrack : "Отсутствует"}
              </LabeledList.Item>

              <LabeledList.Item
                buttons={
                  <Button
                    content="Изъять диск"
                    disabled={!data.disk}
                    onClick={() => act('eject')} />
                } />
            </LabeledList>

          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
