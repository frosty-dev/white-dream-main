import { useBackend } from '../backend';
import { Button, Section, LabeledList } from '../components';
import { Window } from '../layouts';

export const SoundPanelSettings = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    adminhelp,
    midi,
    ambience,
    lobby,
    instruments,
    ship_ambience,
    prayers,
    announcements,
    endofround,
    jukebox,
  } = data;
  return (
    <Window
      width={250}
      height={430}
      title="Настройки звука">
      <Window.Content>
        <Section title="Основное">
          <Button
            icon={midi ? 'volume-up' : 'volume-mute'}
            color={midi ? 'green' : 'transparent'}
            content="Админские мидис"
            fluid
            onClick={() => act('midi')} />
          <Button
            icon={lobby ? 'volume-up' : 'volume-mute'}
            color={lobby ? 'green' : 'transparent'}
            content="Музыка в лобби"
            fluid
            onClick={() => act('lobby')} />
          <Button
            icon={instruments ? 'volume-up' : 'volume-mute'}
            color={instruments ? 'green' : 'transparent'}
            content="Музыкальные инструменты"
            fluid
            onClick={() => act('instruments')} />
          <Button
            icon={announcements ? 'volume-up' : 'volume-mute'}
            color={announcements ? 'green' : 'transparent'}
            content="Оповещения (Announcements)"
            fluid
            onClick={() => act('announcements')} />
          <Button
            icon={endofround ? 'volume-up' : 'volume-mute'}
            color={endofround ? 'green' : 'transparent'}
            content="Звук конца раунда"
            fluid
            onClick={() => act('endofround')} />
          <Button
            icon={jukebox ? 'volume-up' : 'volume-mute'}
            color={jukebox ? 'green' : 'transparent'}
            content="Музыкальный автомат"
            fluid
            onClick={() => act('jukebox')} />
          <Button
            icon={ambience ? 'volume-up' : 'volume-mute'}
            color={ambience ? 'green' : 'transparent'}
            content="Окружение (Ambience)"
            fluid
            onClick={() => act('ambience')} />
          <Button
            icon={ship_ambience ? 'volume-up' : 'volume-mute'}
            color={ship_ambience ? 'green' : 'transparent'}
            content="Шум корабля (Ambience)"
            fluid
            onClick={() => act('ship_ambience')} />
          <Button
            icon="wrench"
            content="Настроить Battletension"
            fluid
            onClick={() => act('bt_customize')} />
          <Button
            icon="play"
            content="Следующий Battletension"
            fluid
            onClick={() => act('switch_track')} />
        </Section>
        <Section title="Педальное">
          <Button
            icon={adminhelp ? 'volume-up' : 'volume-mute'}
            color={adminhelp ? 'green' : 'transparent'}
            content="Ахелпы"
            fluid
            onClick={() => act('adminhelp')} />
          <Button
            icon={prayers ? 'volume-up' : 'volume-mute'}
            color={prayers ? 'green' : 'transparent'}
            content="Молитвы"
            fluid
            onClick={() => act('prayers')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
