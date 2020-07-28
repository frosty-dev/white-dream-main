import { useBackend, useLocalState } from '../backend';
import { Button, LabeledList, Tabs, Input } from '../components';
import { Window } from '../layouts';

export const VerbMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 0);
  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');
  const keys = Object.keys(data.verbs);
  const verbsByTab = data.verbs[keys[tab]];
  const matchingVerbs = verbsByTab.filter((val, key) =>
    val[0].toLowerCase().search(searchText.toLowerCase()) !== -1).sort();
  return (
    <Window
      width={450}
      height={400}
      resizable>
      <Window.Content scrollable>
        {!(keys.length > 1) || (
          <Tabs>
            {keys.map((val, key) => {
              return (
                <Tabs.Tab
                  key={key}
                  // icon="list"
                  lineHeight="25px"
                  selected={tab === key}
                  onClick={() => setTab(key)}>
                  {val}
                </Tabs.Tab>);
            })}
          </Tabs>
        )}
        <Input
          fluid
          mb={1}
          placeholder="Поиск..."
          onInput={(e, value) => setSearchText(value)} />
        {matchingVerbs.map((val, key) => {
          return (
            <Button key={key} content={<font color={val[2]}>{val[0]}</font>}
              onClick={() => act(val[1])} />
          );
        })}
      </Window.Content>
    </Window>
  );
};
