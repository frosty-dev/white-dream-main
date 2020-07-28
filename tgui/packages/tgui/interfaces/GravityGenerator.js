import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const GravityGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    charging_state,
    operational,
  } = data;
  return (
    <Window
      width={400}
      height={165}>
      <Window.Content>
        {!operational && (
          <NoticeBox>
            Нет данных
          </NoticeBox>
        )}
        {!!operational && charging_state !== 0 && (
          <NoticeBox danger>
            ВНИМАНИЕ - Обнаружена радиация
          </NoticeBox>
        )}
        {!!operational && charging_state === 0 && (
          <NoticeBox success>
            Радиации не обнаружено
          </NoticeBox>
        )}
        {!!operational && (
          <GravityGeneratorContent />
        )}
      </Window.Content>
    </Window>
  );
};

const GravityGeneratorContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    breaker,
    charge_count,
    charging_state,
    on,
    operational,
  } = data;
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Рубильник">
          <Button
            icon={breaker ? 'power-off' : 'times'}
            content={breaker ? 'Вкл' : 'Выкл'}
            selected={breaker}
            disabled={!operational}
            onClick={() => act('gentoggle')} />
        </LabeledList.Item>
        <LabeledList.Item label="Гравитация">
          <ProgressBar
            value={charge_count / 100}
            ranges={{
              good: [0.7, Infinity],
              average: [0.3, 0.7],
              bad: [-Infinity, 0.3],
            }} />
        </LabeledList.Item>
        <LabeledList.Item label="Заряд">
          {charging_state === 0 && (
            on && (
              <Box color="good">
                Полностью заряжено
              </Box>
            ) || (
              <Box color="bad">
                Не заряжается
              </Box>
            ))}
          {charging_state === 1 && (
            <Box color="average">
              Заряжается
            </Box>
          )}
          {charging_state === 2 && (
            <Box color="average">
              Разряжается
            </Box>
          )}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
