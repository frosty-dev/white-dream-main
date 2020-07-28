import { useBackend } from '../backend';
import { Button, Icon, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const ImplantChair = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={375}
      height={280}>
      <Window.Content>
        <Section
          title="Пациент"
          textAlign="center">
          <LabeledList>
            <LabeledList.Item label="Имя">
              {data.occupant.name ? data.occupant.name : 'Нет'}
            </LabeledList.Item>
            {!!data.occupied && (
              <LabeledList.Item
                label="Состояние"
                color={data.occupant.stat === 0
                  ? 'good'
                  : data.occupant.stat === 1
                    ? 'average'
                    : 'bad'}>
                {data.occupant.stat === 0
                  ? 'В сознании'
                  : data.occupant.stat === 1
                    ? 'Без сознания'
                    : 'Мёртв'}
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
        <Section
          title="Операции"
          textAlign="center">
          <LabeledList>
            <LabeledList.Item label="Дверца">
              <Button
                icon={data.open ? 'unlock' : 'lock'}
                color={data.open ? 'default' : 'red'}
                content={data.open ? 'Открыта' : 'Закрыта'}
                onClick={() => act('door')} />
            </LabeledList.Item>
            <LabeledList.Item label="Implant Occupant">
              <Button
                icon="code-branch"
                content={data.ready
                  ? (data.special_name || 'Имплантировать')
                  : 'Перезарядка'}
                onClick={() => act('implant')} />
              {data.ready === 0 && (
                <Icon
                  name="cog"
                  color="orange"
                  spin />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Имплантов осталось">
              {data.ready_implants}
              {data.replenishing === 1 && (
                <Icon
                  name="sync"
                  color="red"
                  spin />
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
