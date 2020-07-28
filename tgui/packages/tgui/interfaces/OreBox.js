import { toTitleCase } from 'common/string';
import { Box, Button, Section, Table } from '../components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const OreBox = (props, context) => {
  const { act, data } = useBackend(context);
  const { materials } = data;
  return (
    <Window
      width={335}
      height={415}
      resizable>
      <Window.Content scrollable>
        <Section
          title="Руда"
          buttons={(
            <Button
              content="Пусто"
              onClick={() => act('removeall')} />
          )}>
          <Table>
            <Table.Row header>
              <Table.Cell>
                Руда
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                Количество
              </Table.Cell>
            </Table.Row>
            {materials.map(material => (
              <Table.Row key={material.type}>
                <Table.Cell>
                  {toTitleCase(material.name)}
                </Table.Cell>
                <Table.Cell collapsing textAlign="right">
                  <Box color="label" inline>
                    {material.amount}
                  </Box>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
        <Section>
          <Box>
            Все руды будут размещены здесь, когда вы носите шахтёрскую сумочку
            на поясе или в кармане при перетаскивании коробки с рудой.
            <br />
            Гибтонит не принимается.
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
