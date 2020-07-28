import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { AnimatedNumber, Button, LabeledList, ProgressBar, Section } from '../components';
import { BeakerContents } from './common/BeakerContents';
import { Window } from '../layouts';

const damageTypes = [
  {
    label: "Физический",
    type: "bruteLoss",
  },
  {
    label: "Кислородный",
    type: "oxyLoss",
  },
  {
    label: "Токсины",
    type: "toxLoss",
  },
  {
    label: "Ожоги",
    type: "fireLoss",
  },
];

export const Cryo = () => {
  return (
    <Window
      width={400}
      height={550}
      resizable>
      <Window.Content scrollable>
        <CryoContent />
      </Window.Content>
    </Window>
  );
};

const CryoContent = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Fragment>
      <Section title="Пациент">
        <LabeledList>
          <LabeledList.Item label="Пациент">
            {data.occupant.name || 'Нет пациента'}
          </LabeledList.Item>
          {!!data.hasOccupant && (
            <Fragment>
              <LabeledList.Item
                label="Статус"
                color={data.occupant.statstate}>
                {data.occupant.stat}
              </LabeledList.Item>
              <LabeledList.Item
                label="Температура"
                color={data.occupant.temperaturestatus}>
                <AnimatedNumber
                  value={data.occupant.bodyTemperature} />
                {' K'}
              </LabeledList.Item>
              <LabeledList.Item label="Здоровье">
                <ProgressBar
                  value={data.occupant.health / data.occupant.maxHealth}
                  color={data.occupant.health > 0 ? 'good' : 'average'}>
                  <AnimatedNumber
                    value={data.occupant.health} />
                </ProgressBar>
              </LabeledList.Item>
              {(damageTypes.map(damageType => (
                <LabeledList.Item
                  key={damageType.id}
                  label={damageType.label}>
                  <ProgressBar
                    value={data.occupant[damageType.type]/100}>
                    <AnimatedNumber
                      value={data.occupant[damageType.type]} />
                  </ProgressBar>
                </LabeledList.Item>
              )))}
            </Fragment>
          )}
        </LabeledList>
      </Section>
      <Section title="Камера">
        <LabeledList>
          <LabeledList.Item label="Питание">
            <Button
              icon={data.isOperating ? "power-off" : "times"}
              disabled={data.isOpen}
              onClick={() => act('power')}
              color={data.isOperating && 'green'}>
              {data.isOperating ? "Вкл" : "Выкл"}
            </Button>
          </LabeledList.Item>
          <LabeledList.Item label="Температура">
            <AnimatedNumber value={data.cellTemperature} /> K
          </LabeledList.Item>
          <LabeledList.Item label="Камера">
            <Button
              icon={data.isOpen ? "unlock" : "lock"}
              onClick={() => act('door')}
              content={data.isOpen ? "Открыта" : "Закрыта"} />
            <Button
              icon={data.autoEject ? "sign-out-alt" : "sign-in-alt"}
              onClick={() => act('autoeject')}
              content={data.autoEject ? "Авто" : "Вручную"} />
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Пробирка"
        buttons={(
          <Button
            icon="eject"
            disabled={!data.isBeakerLoaded}
            onClick={() => act('ejectbeaker')}
            content="Изъять" />
        )}>
        <BeakerContents
          beakerLoaded={data.isBeakerLoaded}
          beakerContents={data.beakerContents} />
      </Section>
    </Fragment>
  );
};
