import { Fragment } from 'inferno';
import { useBackend, useSharedState } from '../backend';
import { Button, Flex, LabeledList, NoticeBox, Section, Tabs } from '../components';
import { Window } from '../layouts';

export const TachyonArray = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    records = [],
  } = data;
  return (
    <Window
      width={500}
      height={225}
      resizable>
      <Window.Content scrollable>
        {!records.length ? (
          <NoticeBox>
            Нет записей
          </NoticeBox>
        ) : (
          <TachyonArrayContent />
        )}
      </Window.Content>
    </Window>
  );
};

export const TachyonArrayContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    records = [],
  } = data;
  const [
    activeRecordName,
    setActiveRecordName,
  ] = useSharedState(context, 'record', records[0]?.name);
  const activeRecord = records.find(record => {
    return record.name === activeRecordName;
  });
  return (
    <Section>
      <Flex>
        <Flex.Item>
          <Tabs vertical>
            {records.map(record => (
              <Tabs.Tab
                icon="file"
                key={record.name}
                selected={record.name === activeRecordName}
                onClick={() => setActiveRecordName(record.name)}>
                {record.name}
              </Tabs.Tab>
            ))}
          </Tabs>
        </Flex.Item>
        {activeRecord ? (
          <Flex.Item>
            <Section
              level="2"
              title={activeRecord.name}
              buttons={(
                <Fragment>
                  <Button.Confirm
                    icon="trash"
                    content="Удалить"
                    color="bad"
                    onClick={() => act('delete_record', {
                      'ref': activeRecord.ref,
                    })} />
                  <Button
                    icon="print"
                    content="Печать"
                    onClick={() => act('print_record', {
                      'ref': activeRecord.ref,
                    })} />
                </Fragment>
              )}>
              <LabeledList>
                <LabeledList.Item label="Время">
                  {activeRecord.timestamp}
                </LabeledList.Item>
                <LabeledList.Item label="Координаты">
                  {activeRecord.coordinates}
                </LabeledList.Item>
                <LabeledList.Item label="Смещение">
                  {activeRecord.displacement} seconds
                </LabeledList.Item>
                <LabeledList.Item label="Эпицентр">
                  {activeRecord.factual_epicenter_radius}
                  {activeRecord.theory_epicenter_radius
                  && " (Теоретический: "
                  + activeRecord.theory_epicenter_radius + ")"}
                </LabeledList.Item>
                <LabeledList.Item label="Внешний радиус">
                  {activeRecord.factual_outer_radius}
                  {activeRecord.theory_outer_radius
                  && " (Теоретический: "
                  + activeRecord.theory_outer_radius + ")"}
                </LabeledList.Item>
                <LabeledList.Item label="Взрывная волна">
                  {activeRecord.factual_shockwave_radius}
                  {activeRecord.theory_shockwave_radius
                  && " (Теоретическая: "
                  + activeRecord.theory_shockwave_radius + ")"}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Flex.Item>
        ) : (
          <Flex.Item grow={1} basis={0}>
            <NoticeBox>
              Не выбрана запись
            </NoticeBox>
          </Flex.Item>
        )}
      </Flex>
    </Section>
  );
};
