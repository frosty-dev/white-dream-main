import { useBackend } from '../../backend';
import { Fragment } from 'inferno';
import { Box, Section, LabeledList, Button, AnimatedNumber } from '../../components';

export const PortableBasicInfo = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    connected,
    holding,
    on,
    pressure,
  } = data;

  return (
    <Fragment>
      <Section
        title="Статус"
        buttons={(
          <Button
            icon={on ? 'power-off' : 'times'}
            content={on ? 'Вкл' : 'Выкл'}
            selected={on}
            onClick={() => act('power')} />
        )}>
        <LabeledList>
          <LabeledList.Item label="Давление">
            <AnimatedNumber value={pressure} />
            {' кПа'}
          </LabeledList.Item>
          <LabeledList.Item
            label="Порт"
            color={connected ? 'good' : 'average'}>
            {connected ? 'Подключено' : 'Не подключено'}
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Бак внутри"
        minHeight="82px"
        buttons={(
          <Button
            icon="eject"
            content="Изъять"
            disabled={!holding}
            onClick={() => act('eject')} />
        )}>
        {holding ? (
          <LabeledList>
            <LabeledList.Item label="Label">
              {holding.name}
            </LabeledList.Item>
            <LabeledList.Item label="Давление">
              <AnimatedNumber
                value={holding.pressure} />
              {' кПа'}
            </LabeledList.Item>
          </LabeledList>
        ) : (
          <Box color="average">
            Внутри нет бака
          </Box>
        )}
      </Section>
    </Fragment>
  );
};
