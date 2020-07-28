import { useBackend } from '../backend';
import { Button, NoticeBox, Section, Table } from '../components';
import { Window } from '../layouts';

export const GulagItemReclaimer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    mobs = [],
  } = data;
  return (
    <Window
      width={325}
      height={400}
      resizable>
      <Window.Content scrollable>
        {mobs.length === 0 && (
          <NoticeBox>
            Внутри нет предметов
          </NoticeBox>
        )}
        {mobs.length > 0 && (
          <Section title="Хранимые вещи">
            <Table>
              {mobs.map(mob => (
                <Table.Row key={mob.mob}>
                  <Table.Cell>
                    {mob.name}
                  </Table.Cell>
                  <Table.Cell textAlign="right">
                    <Button
                      content="Вернуть"
                      disabled={!data.can_reclaim}
                      onClick={() => act('release_items', {
                        mobref: mob.mob,
                      })} />
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
