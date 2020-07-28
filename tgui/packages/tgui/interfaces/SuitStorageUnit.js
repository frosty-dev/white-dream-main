import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Icon, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const SuitStorageUnit = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    locked,
    open,
    safeties,
    uv_active,
    occupied,
    suit,
    helmet,
    mask,
    storage,
  } = data;
  return (
    <Window
      width={400}
      height={305}>
      <Window.Content>
        {!!(occupied && safeties) && (
          <NoticeBox>
            Биологический объект обнаружен в камере костюма. Пожалуйста, удалите
            прежде чем продолжить работу.
          </NoticeBox>
        )}
        {uv_active && (
          <NoticeBox>
            Содержимое в настоящее время дезактивируется. Пожалуйста, подождите.
          </NoticeBox>
        ) || (
          <Section
            title="Хранилище"
            minHeight="260px"
            buttons={(
              <Fragment>
                {!open && (
                  <Button
                    icon={locked ? 'unlock' : 'lock'}
                    content={locked ? 'Разблокировать' : 'Заблокировать'}
                    onClick={() => act('lock')} />
                )}
                {!locked && (
                  <Button
                    icon={open ? 'sign-out-alt' : 'sign-in-alt'}
                    content={open ? 'Закрыть' : 'Открыть'}
                    onClick={() => act('door')} />
                )}
              </Fragment>
            )}>
            {locked && (
              <Box
                mt={6}
                bold
                textAlign="center"
                fontSize="40px">
                <Box>Unit Locked</Box>
                <Icon name="lock" />
              </Box>
            ) || open && (
              <LabeledList>
                <LabeledList.Item label="Шлем">
                  <Button
                    icon={helmet ? 'square' : 'square-o'}
                    content={helmet || 'Пусто'}
                    disabled={!helmet}
                    onClick={() => act('dispense', {
                      item: 'helmet',
                    })} />
                </LabeledList.Item>
                <LabeledList.Item label="Костюм">
                  <Button
                    icon={suit ? 'square' : 'square-o'}
                    content={suit || 'Пусто'}
                    disabled={!suit}
                    onClick={() => act('dispense', {
                      item: 'suit',
                    })} />
                </LabeledList.Item>
                <LabeledList.Item label="Маска">
                  <Button
                    icon={mask ? 'square' : 'square-o'}
                    content={mask || 'Пусто'}
                    disabled={!mask}
                    onClick={() => act('dispense', {
                      item: 'mask',
                    })} />
                </LabeledList.Item>
                <LabeledList.Item label="Хранилище">
                  <Button
                    icon={storage ? 'square' : 'square-o'}
                    content={storage || 'Пусто'}
                    disabled={!storage}
                    onClick={() => act('dispense', {
                      item: 'storage',
                    })} />
                </LabeledList.Item>
              </LabeledList>
            ) || (
              <Button
                fluid
                icon="recycle"
                content="Дезинфекция"
                disabled={occupied && safeties}
                textAlign="center"
                onClick={() => act('uv')} />
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
