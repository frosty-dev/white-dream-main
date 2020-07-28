import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const LanguageMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    admin_mode,
    is_living,
    omnitongue,
    languages = [],
    unknown_languages = [],
  } = data;
  return (
    <Window
      title="Language Menu"
      width={700}
      height={600}
      resizable>
      <Window.Content scrollable>
        <Section title="Известные языки">
          <LabeledList>
            {languages.map(language => (
              <LabeledList.Item
                key={language.name}
                label={language.name}
                buttons={(
                  <Fragment>
                    {!!is_living && (
                      <Button
                        content={language.is_default
                          ? 'Стандартный язык'
                          : 'Выбрать как стандартный'}
                        disabled={!language.can_speak}
                        selected={language.is_default}
                        onClick={() => act('select_default', {
                          language_name: language.name,
                        })} />
                    )}
                    {!!admin_mode && (
                      <Fragment>
                        <Button
                          content="Получить"
                          onClick={() => act('grant_language', {
                            language_name: language.name,
                          })} />
                        <Button
                          content="Убрать"
                          onClick={() => act('remove_language', {
                            language_name: language.name,
                          })} />
                      </Fragment>
                    )}
                  </Fragment>
                )}>
                {language.desc}
                {' '}
                Key: ,{language.key}
                {' '}
                {language.can_understand
                  ? 'Понимаю.'
                  : 'Не понимаю.'}
                {' '}
                {language.can_speak
                  ? 'Могу говорить.'
                  : 'Не могу говорить.'}
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
        {!!admin_mode && (
          <Section
            title="Неизвестные языки"
            buttons={(
              <Button
                content={'Омниязык '
                  + (omnitongue ? 'Включен' : 'Выключен')}
                selected={omnitongue}
                onClick={() => act('toggle_omnitongue')} />
            )}>
            <LabeledList>
              {unknown_languages.map(language => (
                <LabeledList.Item
                  key={language.name}
                  label={language.name}
                  buttons={(
                    <Button
                      content="Выдать"
                      onClick={() => act('grant_language', {
                        language_name: language.name,
                      })} />
                  )}>
                  {language.desc}
                  {' '}
                  Key: ,{language.key}
                  {' '}
                  {!!language.shadow && '(получено от существа)'}
                  {' '}
                  {language.can_speak
                    ? 'Могу говорить.'
                    : 'Не могу говорить.' }
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
