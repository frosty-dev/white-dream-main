import { useBackend } from '../backend';
import { Box, Section, LabeledList, Button, ProgressBar } from '../components';
import { Fragment } from 'inferno';
import { Window } from '../layouts';

const damageTypes = [
  {
    label: 'Физический',
    type: 'bruteLoss',
  },
  {
    label: 'Ожоги',
    type: 'fireLoss',
  },
  {
    label: 'Токсины',
    type: 'toxLoss',
  },
  {
    label: 'Удушье',
    type: 'oxyLoss',
  },
];

export const Sleeper = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    open,
    occupant = {},
    occupied,
  } = data;
  const preSortChems = data.chems || [];
  const chems = preSortChems.sort((a, b) => {
    const descA = a.name.toLowerCase();
    const descB = b.name.toLowerCase();
    if (descA < descB) {
      return -1;
    }
    if (descA > descB) {
      return 1;
    }
    return 0;
  });
  return (
    <Window
      width={310}
      height={465}>
      <Window.Content>
        <Section
          title={occupant.name ? occupant.name : 'Нет пациента'}
          minHeight="210px"
          buttons={!!occupant.stat && (
            <Box
              inline
              bold
              color={occupant.statstate}>
              {occupant.stat}
            </Box>
          )}>
          {!!occupied && (
            <Fragment>
              <ProgressBar
                value={occupant.health}
                minValue={occupant.minHealth}
                maxValue={occupant.maxHealth}
                ranges={{
                  good: [50, Infinity],
                  average: [0, 50],
                  bad: [-Infinity, 0],
                }} />
              <Box mt={1} />
              <LabeledList>
                {damageTypes.map(type => (
                  <LabeledList.Item
                    key={type.type}
                    label={type.label}>
                    <ProgressBar
                      value={occupant[type.type]}
                      minValue={0}
                      maxValue={occupant.maxHealth}
                      color="bad" />
                  </LabeledList.Item>
                ))}
                <LabeledList.Item
                  label="Клетки"
                  color={occupant.cloneLoss ? 'bad' : 'good'}>
                  {occupant.cloneLoss ? 'Повреждены' : 'Здоровы'}
                </LabeledList.Item>
                <LabeledList.Item
                  label="Мозг"
                  color={occupant.brainLoss ? 'bad' : 'good'}>
                  {occupant.brainLoss ? 'Повреждён' : 'Здоров'}
                </LabeledList.Item>
              </LabeledList>
            </Fragment>
          )}
        </Section>
        <Section
          title="Химикаты"
          minHeight="205px"
          buttons={(
            <Button
              icon={open ? 'door-open' : 'door-closed'}
              content={open ? 'Открыть' : 'Закрыть'}
              onClick={() => act('door')} />
          )}>
          {chems.map(chem => (
            <Button
              key={chem.name}
              icon="flask"
              content={chem.name}
              disabled={!occupied || !chem.allowed}
              width="140px"
              onClick={() => act('inject', {
                chem: chem.id,
              })} />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};
