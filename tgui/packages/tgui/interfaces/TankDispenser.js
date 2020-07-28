import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const TankDispenser = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={275}
      height={103}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item
              label="Плазма"
              buttons={(
                <Button
                  icon={data.plasma ? 'square' : 'square-o'}
                  content="Выдать"
                  disabled={!data.plasma}
                  onClick={() => act('plasma')} />
              )}>
              {data.plasma}
            </LabeledList.Item>
            <LabeledList.Item
              label="Кислород"
              buttons={(
                <Button
                  icon={data.oxygen ? 'square' : 'square-o'}
                  content="Выдать"
                  disabled={!data.oxygen}
                  onClick={() => act('oxygen')} />
              )}>
              {data.oxygen}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
