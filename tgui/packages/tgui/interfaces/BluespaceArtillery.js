import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const BluespaceArtillery = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    notice,
    connected,
    unlocked,
    target,
  } = data;
  return (
    <Window
      width={400}
      height={220}>
      <Window.Content>
        {!!notice && (
          <NoticeBox>
            {notice}
          </NoticeBox>
        )}
        {connected ? (
          <Fragment>
            <Section
              title="Цель"
              buttons={(
                <Button
                  icon="crosshairs"
                  disabled={!unlocked}
                  onClick={() => act('recalibrate')} />
              )}>
              <Box
                color={target ? 'average' : 'bad'}
                fontSize="25px">
                {target || 'Нет цели'}
              </Box>
            </Section>
            <Section>
              {unlocked ? (
                <Box style={{ margin: 'auto' }}>
                  <Button
                    fluid
                    content="ОГОНЬ"
                    color="bad"
                    disabled={!target}
                    fontSize="30px"
                    textAlign="center"
                    lineHeight="46px"
                    onClick={() => act('fire')} />
                </Box>
              ) : (
                <Fragment>
                  <Box
                    color="bad"
                    fontSize="18px">
                    Блюспейс артиллерия заблокирована.
                  </Box>
                  <Box mt={1}>
                    Ожидается разблокировка от, как минимум, двух
                    авторизованных людей на станции.
                  </Box>
                </Fragment>
              )}
            </Section>
          </Fragment>
        ) : (
          <Section>
            <LabeledList>
              <LabeledList.Item label="Сборка">
                <Button
                  icon="wrench"
                  content="Завершить сборку"
                  onClick={() => act('build')} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
