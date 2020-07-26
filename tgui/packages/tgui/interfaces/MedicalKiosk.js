import { multiline } from 'common/string';
import { useBackend, useSharedState } from '../backend';
import { AnimatedNumber, Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const MedicalKiosk = (props, context) => {
  const { act, data } = useBackend(context);
  const [scanIndex] = useSharedState(context, 'scanIndex');
  const {
    active_status_1,
    active_status_2,
    active_status_3,
    active_status_4,
  } = data;
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Flex mb={1}>
          <Flex.Item mr={1}>
            <Section minHeight="100%">
              <MedicalKioskScanButton
                index={1}
                icon="procedures"
                name="Общее сканирование здоровья"
                description={multiline`
                  Читает обратно точные значения вашего
                  общего сканирования здоровья.
                `} />
              <MedicalKioskScanButton
                index={2}
                icon="heartbeat"
                name="Проверка на основе симптомов"
                description={multiline`
                  Предоставляет информацию на основе
                  различных неочевидных симптомов,
                  как уровень крови или статус болезни.
                `} />
              <MedicalKioskScanButton
                index={3}
                icon="radiation-alt"
                name="Невро/Радиологическое сканирование"
                description={multiline`
                  Предоставляет информацию о травме головного мозга и радиации.
                `} />
              <MedicalKioskScanButton
                index={4}
                icon="mortar-pestle"
                name="Хим. анализ и психоактивное сканирование"
                description={multiline`
                  Предоставляет список потребляемых химических веществ,
                  а также потенциальные побочные эффекты.
                `} />
            </Section>
          </Flex.Item>
          <Flex.Item grow={1} basis={0}>
            <MedicalKioskInstructions />
          </Flex.Item>
        </Flex>
        {!!active_status_1 && scanIndex === 1 && (
          <MedicalKioskScanResults1 />
        )}
        {!!active_status_2 && scanIndex === 2 && (
          <MedicalKioskScanResults2 />
        )}
        {!!active_status_3 && scanIndex === 3 && (
          <MedicalKioskScanResults3 />
        )}
        {!!active_status_4 && scanIndex === 4 && (
          <MedicalKioskScanResults4 />
        )}
      </Window.Content>
    </Window>
  );
};

const MedicalKioskScanButton = (props, context) => {
  const {
    index,
    name,
    description,
    icon,
  } = props;
  const { act, data } = useBackend(context);
  const [scanIndex, setScanIndex] = useSharedState(context, 'scanIndex');
  const paid = data[`active_status_${index}`];
  return (
    <Flex spacing={1} align="baseline">
      <Flex.Item width="16px" textAlign="center">
        <Icon
          name={paid ? 'check' : 'dollar-sign'}
          color={paid ? 'green' : 'grey'} />
      </Flex.Item>
      <Flex.Item grow={1}>
        <Button
          fluid
          icon={icon}
          selected={paid && scanIndex === index}
          tooltip={description}
          tooltipPosition="right"
          content={name}
          onClick={() => {
            act(`beginScan_${index}`);
            setScanIndex(index);
          }} />
      </Flex.Item>
    </Flex>
  );
};

const MedicalKioskInstructions = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    kiosk_cost,
    patient_name,
  } = data;
  return (
    <Section minHeight="100%">
      <Box italic>
        Приветствую, уважаемый сотрудник. Пожалуйста, выберите
        желаемую процедуру.
        Стоимость процедуры <b>{data.kiosk_cost} кредитов</b>.
      </Box>
      <Box mt={1}>
        <Box inline color="label" mr={1}>
          Текущий пациент:
        </Box>
        {patient_name}
      </Box>
      <Button
        mt={1}
        tooltip={multiline`
         Сбрасывает текущую цель сканирования, отменяя текущие сканирования.
        `}
        icon="sync"
        color="average"
        onClick={() => act('clearTarget')}
        content="Сбросить сканер" />
    </Section>
  );
};

const MedicalKioskScanResults1 = (props, context) => {
  const { data } = useBackend(context);
  const {
    patient_health,
    brute_health,
    burn_health,
    suffocation_health,
    toxin_health,
  } = data;
  return (
    <Section title="Здоровье пациента">
      <LabeledList>
        <LabeledList.Item
          label="Общее здоровье">
          <ProgressBar
            value={patient_health / 100}>
            <AnimatedNumber value={patient_health} />%
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item
          label="Физический урон">
          <ProgressBar
            value={brute_health / 100}
            color="bad">
            <AnimatedNumber value={brute_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item
          label="Ожоги">
          <ProgressBar
            value={burn_health / 100}
            color="bad">
            <AnimatedNumber value={burn_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item
          label="Кислородный урон">
          <ProgressBar
            value={suffocation_health / 100}
            color="bad">
            <AnimatedNumber value={suffocation_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item
          label="Интоксикация">
          <ProgressBar
            value={toxin_health / 100}
            color="bad">
            <AnimatedNumber value={toxin_health} />
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const MedicalKioskScanResults2 = (props, context) => {
  const { data } = useBackend(context);
  const {
    patient_status,
    patient_illness,
    illness_info,
    bleed_status,
    blood_levels,
    blood_status,
  } = data;
  return (
    <Section title="Проверка на основе симптомов">
      <LabeledList>
        <LabeledList.Item
          label="Состояние пациента"
          color="good">
          {patient_status}
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item
          label="Состояние болезни">
          {patient_illness}
        </LabeledList.Item>
        <LabeledList.Item
          label="Информация о болезни">
          {illness_info}
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item
          label="Уровень крови">
          <ProgressBar
            value={blood_levels / 100}
            color="bad">
            <AnimatedNumber value={blood_levels} />
          </ProgressBar>
          <Box mt={1} color="label">
            {bleed_status}
          </Box>
        </LabeledList.Item>
        <LabeledList.Item
          label="Информация о крови">
          {blood_status}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const MedicalKioskScanResults3 = (props, context) => {
  const { data } = useBackend(context);
  const {
    clone_health,
    brain_damage,
    brain_health,
    rad_contamination_status,
    rad_contamination_value,
    rad_sickness_status,
    rad_sickness_value,
    trauma_status,
  } = data;
  return (
    <Section title="Невро/Радиологическое сканирование">
      <LabeledList>
        <LabeledList.Item
          label="Клеточный урон">
          <ProgressBar
            value={clone_health / 100}
            color="good">
            <AnimatedNumber value={clone_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item
          label="Повреждения мозга">
          <ProgressBar
            value={brain_damage / 100}
            color="good">
            <AnimatedNumber value={brain_damage} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item
          label="Состояние мозга"
          color="health-0">
          {brain_health}
        </LabeledList.Item>
        <LabeledList.Item
          label="Травмы головного мозга">
          {trauma_status}
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item
          label="Radiation Sickness Status">
          {rad_sickness_status}
        </LabeledList.Item>
        <LabeledList.Item
          label="Процент лучевой болезни">
          {rad_sickness_value}%
        </LabeledList.Item>
        <LabeledList.Item
          label="Состояние радиационного загрязнения">
          {rad_contamination_status}
        </LabeledList.Item>
        <LabeledList.Item
          label="Процент радиационного загрязнения">
          {rad_contamination_value}%
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const MedicalKioskScanResults4 = (props, context) => {
  const { data } = useBackend(context);
  const {
    chemical_list = [],
    overdose_list = [],
    addict_list = [],
    hallucinating_status,
  } = data;
  return (
    <Section title="Хим. анализ и психоактивное сканирование">
      <LabeledList>
        <LabeledList.Item
          label="Химикаты в крови">
          {chemical_list.length === 0 && (
            <Box color="average">
              Не обнаружено реагентов.
            </Box>
          )}
          {chemical_list.map(chem => (
            <Box
              key={chem.id}
              color="good">
              {chem.volume} единиц {chem.name}
            </Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Item
          label="Состояние передозировки"
          color="bad">
          {overdose_list.length === 0 && (
            <Box color="good">
              Пациент не испытывает передозировку.
            </Box>
          )}
          {overdose_list.map(chem => (
            <Box key={chem.id}>
              Передозировка {chem.name}
            </Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Item
          label="Состояние зависимостей"
          color="bad">
          {addict_list.length === 0 && (
            <Box color="good">
              Нет зависимостей.
            </Box>
          )}
          {addict_list.map(chem => (
            <Box key={chem.id}>
              Зависимость от {chem.name}
            </Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Item
          label="Психоактивное состояние">
          {hallucinating_status}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
