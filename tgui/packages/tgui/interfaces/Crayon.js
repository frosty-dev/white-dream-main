import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const Crayon = (props, context) => {
  const { act, data } = useBackend(context);
  const capOrChanges = data.has_cap || data.can_change_colour;
  const drawables = data.drawables || [];
  return (
    <Window
      width={600}
      height={600}
      resizable>
      <Window.Content scrollable>
        {!!capOrChanges && (
          <Section title="Базовое">
            <LabeledList>
              <LabeledList.Item label="Крышка">
                <Button
                  icon={data.is_capped ? 'power-off' : 'times'}
                  content={data.is_capped ? 'Есть' : 'Нет'}
                  selected={data.is_capped}
                  onClick={() => act('toggle_cap')} />
              </LabeledList.Item>
            </LabeledList>
            <Button
              content="Выбрать новый цвет"
              onClick={() => act('select_colour')} />
          </Section>
        )}
        <Section title="Шаблон">
          <LabeledList>
            {drawables.map(drawable => {
              const items = drawable.items || [];
              return (
                <LabeledList.Item
                  key={drawable.name}
                  label={drawable.name}>
                  {items.map(item => (
                    <Button
                      key={item.item}
                      content={item.item}
                      selected={item.item === data.selected_stencil}
                      onClick={() => act('select_stencil', {
                        item: item.item,
                      })} />
                  ))}
                </LabeledList.Item>
              );
            })}
          </LabeledList>
        </Section>
        <Section title="Текст">
          <LabeledList>
            <LabeledList.Item label="Текущий буффер">
              {data.text_buffer}
            </LabeledList.Item>
          </LabeledList>
          <Button
            content="Новый текст"
            onClick={() => act('enter_text')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
