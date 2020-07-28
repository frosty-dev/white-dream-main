import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const dangerMap = {
  2: {
    color: 'good',
    localStatusText: 'Выключено',
  },
  1: {
    color: 'average',
    localStatusText: 'Опасно',
  },
  0: {
    color: 'bad',
    localStatusText: 'Оптимально',
  },
};

export const AiAirlock = (props, context) => {
  const { act, data } = useBackend(context);
  const statusMain = dangerMap[data.power.main] || dangerMap[0];
  const statusBackup = dangerMap[data.power.backup] || dangerMap[0];
  const statusElectrify = dangerMap[data.shock] || dangerMap[0];
  return (
    <Window
      width={500}
      height={390}>
      <Window.Content>
        <Section title="Состояние питания">
          <LabeledList>
            <LabeledList.Item
              label="Основное"
              color={statusMain.color}
              buttons={(
                <Button
                  icon="lightbulb-o"
                  disabled={!data.power.main}
                  content="Нарушить"
                  onClick={() => act('disrupt-main')} />
              )}>
              {data.power.main ? 'В сети' : 'Отключено'}
              {' '}
              {(!data.wires.main_1 || !data.wires.main_2)
                && '[Провода обрезаны!]'
                || (data.power.main_timeleft > 0
                  && `[${data.power.main_timeleft}с]`)}
            </LabeledList.Item>
            <LabeledList.Item
              label="Запасное"
              color={statusBackup.color}
              buttons={(
                <Button
                  icon="lightbulb-o"
                  disabled={!data.power.backup}
                  content="Нарушить"
                  onClick={() => act('disrupt-backup')} />
              )}>
              {data.power.backup ? 'В сети' : 'Отключено'}
              {' '}
              {(!data.wires.backup_1 || !data.wires.backup_2)
                && '[Провода обрезаны!]'
                || (data.power.backup_timeleft > 0
                  && `[${data.power.backup_timeleft}с]`)}
            </LabeledList.Item>
            <LabeledList.Item
              label="Шокер"
              color={statusElectrify.color}
              buttons={(
                <Fragment>
                  <Button
                    icon="wrench"
                    disabled={!(data.wires.shock && data.shock === 0)}
                    content="Восстановить"
                    onClick={() => act('shock-restore')} />
                  <Button
                    icon="bolt"
                    disabled={!data.wires.shock}
                    content="Временно"
                    onClick={() => act('shock-temp')} />
                  <Button
                    icon="bolt"
                    disabled={!data.wires.shock}
                    content="Всегда"
                    onClick={() => act('shock-perm')} />
                </Fragment>
              )}>
              {data.shock === 2 ? 'Безопасно' : 'Напряжение'}
              {' '}
              {!data.wires.shock
                && '[Провода обрезаны!]'
                || (data.shock_timeleft > 0
                  && `[${data.shock_timeleft}s]`)
                || (data.shock_timeleft === -1
                  && '[Всегда]')}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Управление шлюзом и доступ">
          <LabeledList>
            <LabeledList.Item
              label="Сканирование ID"
              color="bad"
              buttons={(
                <Button
                  icon={data.id_scanner ? 'power-off' : 'times'}
                  content={data.id_scanner ? 'Включено' : 'Отключено'}
                  selected={data.id_scanner}
                  disabled={!data.wires.id_scanner}
                  onClick={() => act('idscan-toggle')} />
              )}>
              {!data.wires.id_scanner && '[Провода обрезаны!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Аварийный доступ"
              buttons={(
                <Button
                  icon={data.emergency ? 'power-off' : 'times'}
                  content={data.emergency ? 'Включено' : 'Отключено'}
                  selected={data.emergency}
                  onClick={() => act('emergency-toggle')} />
              )} />
            <LabeledList.Divider />
            <LabeledList.Item
              label="Болты шлюза"
              color="bad"
              buttons={(
                <Button
                  icon={data.locked ? 'lock' : 'unlock'}
                  content={data.locked ? 'Опущены' : 'Подняты'}
                  selected={data.locked}
                  disabled={!data.wires.bolts}
                  onClick={() => act('bolt-toggle')} />
              )}>
              {!data.wires.bolts && '[Провода обрезаны!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Индикация состояния болтов"
              color="bad"
              buttons={(
                <Button
                  icon={data.lights ? 'power-off' : 'times'}
                  content={data.lights ? 'Включено' : 'Отключено'}
                  selected={data.lights}
                  disabled={!data.wires.lights}
                  onClick={() => act('light-toggle')} />
              )}>
              {!data.wires.lights && '[Провода обрезаны!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Сенсоры принудительного закрытия"
              color="bad"
              buttons={(
                <Button
                  icon={data.safe ? 'power-off' : 'times'}
                  content={data.safe ? 'Включены' : 'Отключены'}
                  selected={data.safe}
                  disabled={!data.wires.safe}
                  onClick={() => act('safe-toggle')} />
              )}>
              {!data.wires.safe && '[Провода обрезаны!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Таймер шлюза"
              color="bad"
              buttons={(
                <Button
                  icon={data.speed ? 'power-off' : 'times'}
                  content={data.speed ? 'Включено' : 'Отключено'}
                  selected={data.speed}
                  disabled={!data.wires.timing}
                  onClick={() => act('speed-toggle')} />
              )}>
              {!data.wires.timing && '[Провода обрезаны!]'}
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item
              label="Контроль шлюза"
              color="bad"
              buttons={(
                <Button
                  icon={data.opened ? 'sign-out-alt' : 'sign-in-alt'}
                  content={data.opened ? 'Открыт' : 'Закрыт'}
                  selected={data.opened}
                  disabled={(data.locked || data.welded)}
                  onClick={() => act('open-close')} />
              )}>
              {!!(data.locked || data.welded) && (
                <span>
                  [{data.locked ? 'Болты опущены' : ''}
                  {(data.locked && data.welded) ? ' и ' : ''}
                  {data.welded ? 'шлюз заварен' : ''}!]
                </span>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
