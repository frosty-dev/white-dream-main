/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { Button, Section, Stack } from 'tgui/components';
import { Pane } from 'tgui/layouts';
import { NowPlayingWidget, useAudio } from './audio';
import { ChatPanel, ChatTabs } from './chat';
import { useGame } from './game';
import { Notifications } from './Notifications';
import { PingIndicator } from './ping';
import { SettingsPanel, useSettings } from './settings';
import { useLocalState } from 'tgui/backend';

export const Panel = (props, context) => {
  // IE8-10: Needs special treatment due to missing Flex support
  if (Byond.IS_LTE_IE10) {
    return (
      <HoboPanel />
    );
  }
  const audio = useAudio(context);
  const settings = useSettings(context);
  const game = useGame(context);
  const [things, setThings] = useLocalState(context, 'things', 1);
  if (process.env.NODE_ENV !== 'production') {
    const { useDebug, KitchenSink } = require('tgui/debug');
    const debug = useDebug(context);
    if (debug.kitchenSink) {
      return (
        <KitchenSink panel />
      );
    }
  }
  return (
    <Pane theme={settings.theme}>
      <Stack fill vertical>
        <Stack.Item>
          <Section fitted>
            <Stack mr={1} align="center">
              <Stack.Item grow overflowX="auto">
                <ChatTabs />
              </Stack.Item>
              <Stack.Item>
                <Button
                  color="grey"
                  tooltip={things ? "Скрыть" : "Показать"}
                  tooltipPosition="bottom"
                  icon={things ? "angle-double-right" : "angle-double-left"}
                  onClick={() => setThings(!things)} />
              </Stack.Item>
              {!!things && (
                <Stack.Item>
                  <Button
                    color="green"
                    tooltip="Wiki"
                    tooltipPosition="bottom"
                    icon="book"
                    onClick={() => Byond.command('wiki')} />
                </Stack.Item>
              )}
              {!!things && (
                <Stack.Item>
                  <Button
                    color="teal"
                    tooltip="Наша Discord-конференция"
                    tooltipPosition="bottom"
                    icon="comments"
                    onClick={() => Byond.command('forum')} />
                </Stack.Item>
              )}
              {!!things && (
                <Stack.Item>
                  <Button
                    color="yellow"
                    tooltip="Донат-панель"
                    tooltipPosition="bottom"
                    icon="shopping-basket"
                    onClick={() => Byond.command('Панель-благотворца')} />
                </Stack.Item>
              )}
              <Stack.Item>
                <PingIndicator />
              </Stack.Item>
              <Stack.Item>
                <Button
                  color="grey"
                  selected={audio.visible}
                  icon="music"
                  tooltip="Плеер"
                  tooltipPosition="bottom-left"
                  onClick={() => audio.toggle()} />
              </Stack.Item>
              <Stack.Item>
                <Button
                  icon={settings.visible ? 'times' : 'cog'}
                  selected={settings.visible}
                  tooltip={settings.visible
                    ? 'Закрыть настройки'
                    : 'Открыть настройки'}
                  tooltipPosition="bottom-left"
                  onClick={() => settings.toggle()} />
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
        {audio.visible && (
          <Stack.Item>
            <Section>
              <NowPlayingWidget />
            </Section>
          </Stack.Item>
        )}
        {settings.visible && (
          <Stack.Item>
            <SettingsPanel />
          </Stack.Item>
        )}
        <Stack.Item grow>
          <Section fill fitted position="relative">
            <Pane.Content scrollable>
              <ChatPanel lineHeight={settings.lineHeight} />
            </Pane.Content>
            <Notifications>
              {game.connectionLostAt && (
                <Notifications.Item
                  rightSlot={(
                    <Button
                      color="white"
                      onClick={() => Byond.command('.reconnect')}>
                      Переподключиться
                    </Button>
                  )}>
                  Сервер перезагружается. Если сообщение висит
                  более двух минут, то можете нажать на кнопку справа.
                </Notifications.Item>
              )}
              {game.roundRestartedAt && (
                <Notifications.Item>
                  Соединение было закрыто по причине  перезагрузки сервера.
                  Пожалуйста, подождите. Игра сама переподключится к серверу.
                  Это может занять 30 секунд и более, учтите!
                </Notifications.Item>
              )}
            </Notifications>
          </Section>
        </Stack.Item>
      </Stack>
    </Pane>
  );
};

const HoboPanel = (props, context) => {
  const settings = useSettings(context);
  return (
    <Pane theme={settings.theme}>
      <Pane.Content scrollable>
        <Button
          style={{
            position: 'fixed',
            top: '1em',
            right: '2em',
            'z-index': 1000,
          }}
          selected={settings.visible}
          onClick={() => settings.toggle()}>
          Настройки
        </Button>
        {settings.visible && (
          <SettingsPanel />
        ) || (
          <ChatPanel lineHeight={settings.lineHeight} />
        )}
      </Pane.Content>
    </Pane>
  );
};
