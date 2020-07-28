import { useBackend } from '../backend';
import { AnimatedNumber, Button, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const MechBayPowerConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const { recharge_port } = data;
  const mech = recharge_port && recharge_port.mech;
  const cell = mech && mech.cell;
  return (
    <Window
      width={400}
      height={200}>
      <Window.Content>
        <Section
          title="Состояние меха"
          textAlign="center"
          buttons={(
            <Button
              icon="sync"
              content="Синхр."
              onClick={() => act('reconnect')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Состояние">
              {!recharge_port && (
                <NoticeBox>
                  Не обнаружено энергопортов.
                </NoticeBox>
              ) || !mech && (
                <NoticeBox>
                  Не обнаружено меха.
                </NoticeBox>
              ) || (
                <ProgressBar
                  value={mech.health / mech.maxhealth}
                  ranges={{
                    good: [0.7, Infinity],
                    average: [0.3, 0.7],
                    bad: [-Infinity, 0.3],
                  }} />
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Питание">
              {!recharge_port && (
                <NoticeBox>
                  Не обнаружено энергопортов.
                </NoticeBox>
              ) || !mech && (
                <NoticeBox>
                  Не обнаружено меха.
                </NoticeBox>
              ) || !cell && (
                <NoticeBox>
                  Нет аккумулятора.
                </NoticeBox>
              ) || (
                <ProgressBar
                  value={cell.charge / cell.maxcharge}
                  ranges={{
                    good: [0.7, Infinity],
                    average: [0.3, 0.7],
                    bad: [-Infinity, 0.3],
                  }}>
                  <AnimatedNumber value={cell.charge} />
                  {' / ' + cell.maxcharge}
                </ProgressBar>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
