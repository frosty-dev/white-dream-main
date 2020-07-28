import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const BorgPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const borg = data.borg || {};
  const cell = data.cell || {};
  const cellPercent = cell.charge / cell.maxcharge;
  const channels = data.channels || [];
  const modules = data.modules || [];
  const upgrades = data.upgrades || [];
  const ais = data.ais || [];
  const laws = data.laws || [];
  return (
    <Window
      title="Borg Panel"
      width={700}
      height={700}
      resizable>
      <Window.Content scrollable>
        <Section
          title={borg.name}
          buttons={(
            <Button
              icon="pencil-alt"
              content="Переименовать"
              onClick={() => act('rename')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Статус">
              <Button
                icon={borg.emagged ? 'check-square-o' : 'square-o'}
                content="Взломано"
                selected={borg.emagged}
                onClick={() => act('toggle_emagged')} />
              <Button
                icon={borg.lockdown ? 'check-square-o' : 'square-o'}
                content="Заблокировано"
                selected={borg.lockdown}
                onClick={() => act('toggle_lockdown')} />
              <Button
                icon={borg.scrambledcodes ? 'check-square-o' : 'square-o'}
                content="Шифрованные коды"
                selected={borg.scrambledcodes}
                onClick={() => act('toggle_scrambledcodes')} />
            </LabeledList.Item>
            <LabeledList.Item label="Заряд">
              {!cell.missing ? (
                <ProgressBar
                  value={cellPercent}>
                  {cell.charge + ' / ' + cell.maxcharge}
                </ProgressBar>
              ) : (
                <span className="color-bad">
                  Нет установленной батарейки
                </span>
              )}
              <br />
              <Button
                icon="pencil-alt"
                content="Выставить"
                onClick={() => act('set_charge')} />
              <Button
                icon="eject"
                content="Изменить"
                onClick={() => act('change_cell')} />
              <Button
                icon="trash"
                content="Удалить"
                color="bad"
                onClick={() => act('remove_cell')} />
            </LabeledList.Item>
            <LabeledList.Item label="Радиоканалы">
              {channels.map(channel => (
                <Button
                  key={channel.name}
                  icon={channel.installed ? 'check-square-o' : 'square-o'}
                  content={channel.name}
                  selected={channel.installed}
                  onClick={() => act('toggle_radio', {
                    channel: channel.name,
                  })} />
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Модули">
              {modules.map(module => (
                <Button
                  key={module.type}
                  icon={borg.active_module === module.type
                    ? 'check-square-o'
                    : 'square-o'}
                  content={module.name}
                  selected={borg.active_module === module.type}
                  onClick={() => act('setmodule', {
                    module: module.type,
                  })} />
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Обновления">
              {upgrades.map(upgrade => (
                <Button
                  key={upgrade.type}
                  icon={upgrade.installed ? 'check-square-o' : 'square-o'}
                  content={upgrade.name}
                  selected={upgrade.installed}
                  onClick={() => act('toggle_upgrade', {
                    upgrade: upgrade.type,
                  })} />
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Мастер ИИ">
              {ais.map(ai => (
                <Button
                  key={ai.ref}
                  icon={ai.connected ? 'check-square-o' : 'square-o'}
                  content={ai.name}
                  selected={ai.connected}
                  onClick={() => act('slavetoai', {
                    slavetoai: ai.ref,
                  })} />
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="Законы"
          buttons={(
            <Button
              icon={borg.lawupdate ? 'check-square-o' : 'square-o'}
              content="Синхронизировать"
              selected={borg.lawupdate}
              onClick={() => act('toggle_lawupdate')} />
          )}>
          {laws.map(law => (
            <Box key={law}>
              {law}
            </Box>
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
