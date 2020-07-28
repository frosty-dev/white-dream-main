import { map } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Box, Button, Collapsible, Grid, Input, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const PandemicBeakerDisplay = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_beaker,
    beaker_empty,
    has_blood,
    blood,
  } = data;
  const cant_empty = !has_beaker || beaker_empty;
  return (
    <Section
      title="Пробирка"
      buttons={(
        <Fragment>
          <Button
            icon="times"
            content="Опустошить и извлечь"
            color="bad"
            disabled={cant_empty}
            onClick={() => act('empty_eject_beaker')} />
          <Button
            icon="trash"
            content="Опустошить"
            disabled={cant_empty}
            onClick={() => act('empty_beaker')} />
          <Button
            icon="eject"
            content="Извлечь"
            disabled={!has_beaker}
            onClick={() => act('eject_beaker')} />
        </Fragment>
      )}>
      {has_beaker ? (
        !beaker_empty ? (
          has_blood ? (
            <LabeledList>
              <LabeledList.Item label="ДНК крови">
                {(blood && blood.dna) || 'Неизвестно'}
              </LabeledList.Item>
              <LabeledList.Item label="Группа крови">
                {(blood && blood.type) || 'Неизвестно'}
              </LabeledList.Item>
            </LabeledList>
          ) : (
            <Box color="bad">
              Не обнаружено крови
            </Box>
          )
        ) : (
          <Box color="bad">
            Пробирка пуста
          </Box>
        )
      ) : (
        <NoticeBox>
          Нет пробирки
        </NoticeBox>
      )}
    </Section>
  );
};

export const PandemicDiseaseDisplay = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    is_ready,
  } = data;
  const viruses = data.viruses || [];
  return (
    viruses.map(virus => {
      const symptoms = virus.symptoms || [];
      return (
        <Section
          key={virus.name}
          title={virus.can_rename ? (
            <Input
              value={virus.name}
              onChange={(e, value) => act('rename_disease', {
                index: virus.index,
                name: value,
              })} />
          ) : (
            virus.name
          )}
          buttons={(
            <Button
              icon="flask"
              content="Создать образец"
              disabled={!is_ready}
              onClick={() => act('create_culture_bottle', {
                index: virus.index,
              })} />
          )}>
          <Grid>
            <Grid.Column>
              {virus.description}
            </Grid.Column>
            <Grid.Column>
              <LabeledList>
                <LabeledList.Item label="Представитель">
                  {virus.agent}
                </LabeledList.Item>
                <LabeledList.Item label="Распространение">
                  {virus.spread}
                </LabeledList.Item>
                <LabeledList.Item label="Возможная вакцина">
                  {virus.cure}
                </LabeledList.Item>
              </LabeledList>
            </Grid.Column>
          </Grid>
          {!!virus.is_adv && (
            <Fragment>
              <Section
                title="Статистика"
                level={2}>
                <Grid>
                  <Grid.Column>
                    <LabeledList>
                      <LabeledList.Item label="Сопротивление">
                        {virus.resistance}
                      </LabeledList.Item>
                      <LabeledList.Item label="Скрытность">
                        {virus.stealth}
                      </LabeledList.Item>
                    </LabeledList>
                  </Grid.Column>
                  <Grid.Column>
                    <LabeledList>
                      <LabeledList.Item label="Скорость">
                        {virus.stage_speed}
                      </LabeledList.Item>
                      <LabeledList.Item label="Передача">
                        {virus.transmission}
                      </LabeledList.Item>
                    </LabeledList>
                  </Grid.Column>
                </Grid>
              </Section>
              <Section
                title="Симптомы"
                level={2}>
                {symptoms.map(symptom => (
                  <Collapsible
                    key={symptom.name}
                    title={symptom.name}>
                    <Section>
                      <PandemicSymptomDisplay symptom={symptom} />
                    </Section>
                  </Collapsible>
                ))}
              </Section>
            </Fragment>
          )}
        </Section>
      );
    })
  );
};

export const PandemicSymptomDisplay = (props, context) => {
  const { symptom } = props;
  const {
    name,
    desc,
    stealth,
    resistance,
    stage_speed,
    transmission,
    level,
    neutered,
  } = symptom;
  const thresholds = map((desc, label) => ({ desc, label }))(
    symptom.threshold_desc || {});
  return (
    <Section
      title={name}
      level={2}
      buttons={!!neutered && (
        <Box
          bold
          color="bad">
          Neutered
        </Box>
      )}>
      <Grid>
        <Grid.Column size={2}>
          {desc}
        </Grid.Column>
        <Grid.Column>
          <LabeledList>
            <LabeledList.Item label="Уровень">
              {level}
            </LabeledList.Item>
            <LabeledList.Item label="Сопротивление">
              {resistance}
            </LabeledList.Item>
            <LabeledList.Item label="Скрытность">
              {stealth}
            </LabeledList.Item>
            <LabeledList.Item label="Скорость">
              {stage_speed}
            </LabeledList.Item>
            <LabeledList.Item label="Передача">
              {transmission}
            </LabeledList.Item>
          </LabeledList>
        </Grid.Column>
      </Grid>
      {thresholds.length > 0 && (
        <Section
          title="Задержки"
          level={3}>
          <LabeledList>
            {thresholds.map(threshold => {
              return (
                <LabeledList.Item
                  key={threshold.label}
                  label={threshold.label}>
                  {threshold.desc}
                </LabeledList.Item>
              );
            })}
          </LabeledList>
        </Section>
      )}
    </Section>
  );
};

export const PandemicAntibodyDisplay = (props, context) => {
  const { act, data } = useBackend(context);
  const resistances = data.resistances || [];
  return (
    <Section title="Антитела">
      {resistances.length > 0 ? (
        <LabeledList>
          {resistances.map(resistance => (
            <LabeledList.Item
              key={resistance.name}
              label={resistance.name}>
              <Button
                icon="eye-dropper"
                content="Создать вакцину"
                disabled={!data.is_ready}
                onClick={() => act('create_vaccine_bottle', {
                  index: resistance.id,
                })} />
            </LabeledList.Item>
          ))}
        </LabeledList>
      ) : (
        <Box
          bold
          color="bad"
          mt={1}>
          No antibodies detected.
        </Box>
      )}
    </Section>
  );
};

export const Pandemic = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Window
      width={520}
      height={550}
      resizable>
      <Window.Content scrollable>
        <PandemicBeakerDisplay />
        {!!data.has_blood && (
          <Fragment>
            <PandemicDiseaseDisplay />
            <PandemicAntibodyDisplay />
          </Fragment>
        )}
      </Window.Content>
    </Window>
  );
};
