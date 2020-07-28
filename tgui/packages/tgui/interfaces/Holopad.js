import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Flex, Icon, LabeledList, Modal, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const Holopad = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    calling,
  } = data;
  return (
    <Window
      width={440}
      height={245}
      resizable>
      {!!calling && (
        <Modal
          fontSize="36px"
          fontFamily="monospace">
          <Flex align="center">
            <Flex.Item mr={2} mt={2}>
              <Icon
                name="phone-alt"
                rotation={25} />
            </Flex.Item>
            <Flex.Item mr={2}>
              {'Звоним...'}
            </Flex.Item>
          </Flex>
          <Box
            mt={2}
            textAlign="center"
            fontSize="24px">
            <Button
              lineHeight="40px"
              icon="times"
              content="Сбросить"
              color="bad"
              onClick={() => act('hang_up')} />
          </Box>
        </Modal>
      )}
      <Window.Content scrollable>
        <HolopadContent />
      </Window.Content>
    </Window>
  );
};

const HolopadContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    on_network,
    on_cooldown,
    allowed,
    disk,
    disk_record,
    replay_mode,
    loop_mode,
    record_mode,
    holo_calls = [],
  } = data;
  return (
    <Fragment>
      <Section
        title="Holopad"
        buttons={(
          <Button
            icon="bell"
            content={on_cooldown
              ? "ИИ запрошен"
              : "Запросить ИИ"}
            disabled={!on_network || on_cooldown}
            onClick={() => act('AIrequest')} />
        )} >
        <LabeledList>
          <LabeledList.Item label="Коммуникатор">
            <Button
              icon="phone-alt"
              content={allowed ? "Подключиться к Holopad" : "Вызвать Holopad"}
              disabled={!on_network}
              onClick={() => act('holocall', { headcall: allowed })} />
          </LabeledList.Item>
          {holo_calls.map((call => {
            return (
              <LabeledList.Item
                label={call.connected
                  ? "Текущий звонок"
                  : "Входящий звонок"}
                key={call.ref}>
                <Button
                  icon={call.connected ? 'phone-slash' : 'phone-alt'}
                  content={call.connected
                    ? "Отключиться от " + call.caller
                    : "Запросить от " + call.caller}
                  color={call.connected ? 'bad' : 'good'}
                  disabled={!on_network}
                  onClick={() => act(call.connected
                    ? 'disconnectcall'
                    : 'connectcall', { holopad: call.ref })} />
              </LabeledList.Item>
            );
          }))}
        </LabeledList>
      </Section>
      <Section
        title="Holo-диск"
        buttons={
          <Button
            icon="eject"
            content="Изъять"
            disabled={!disk || replay_mode || record_mode}
            onClick={() => act('disk_eject')} />
        }>
        {!disk && (
          <NoticeBox>
            Нет Holo-диска
          </NoticeBox>
        ) || (
          <LabeledList>
            <LabeledList.Item label="Проигрыватель">
              <Button
                icon={replay_mode ? 'pause' : 'play'}
                content={replay_mode ? 'Стоп' : 'Играть'}
                selected={replay_mode}
                disabled={record_mode || !disk_record}
                onClick={() => act('replay_mode')} />
              <Button
                icon={'sync'}
                content={loop_mode ? 'Повторяем' : 'Повторять'}
                selected={loop_mode}
                disabled={record_mode || !disk_record}
                onClick={() => act('loop_mode')} />
              <Button
                icon="exchange-alt"
                content="Смещение"
                disabled={!replay_mode}
                onClick={() => act('offset')} />
            </LabeledList.Item>
            <LabeledList.Item label="Записыватель">
              <Button
                icon={record_mode ? 'pause' : 'video'}
                content={record_mode ? 'Завершить' : 'Записывать'}
                selected={record_mode}
                disabled={(disk_record && !record_mode) || replay_mode}
                onClick={() => act('record_mode')} />
              <Button
                icon="trash"
                content="Очистить запись"
                color="bad"
                disabled={!disk_record || replay_mode || record_mode}
                onClick={() => act('record_clear')} />
            </LabeledList.Item>
          </LabeledList>
        )}
      </Section>
    </Fragment>
  );
};
