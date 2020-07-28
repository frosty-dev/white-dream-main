import { toFixed } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { AnimatedNumber, Box, Button, Icon, Knob, LabeledControls, LabeledList, Section, Tooltip } from '../components';
import { formatSiUnit } from '../format';
import { Window } from '../layouts';

export const Canister = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    portConnected,
    tankPressure,
    releasePressure,
    defaultReleasePressure,
    minReleasePressure,
    maxReleasePressure,
    valveOpen,
    isPrototype,
    hasHoldingTank,
    holdingTank,
    restricted,
  } = data;
  return (
    <Window
      width={300}
      height={232}>
      <Window.Content>
        <Section
          title="Бак"
          buttons={(
            <Fragment>
              {!!isPrototype && (
                <Button
                  mr={1}
                  icon={restricted ? 'lock' : 'unlock'}
                  color="caution"
                  content={restricted
                    ? 'Инженерный'
                    : 'Публичный'}
                  onClick={() => act('restricted')} />
              )}
              <Button
                icon="pencil-alt"
                content="Переименовать"
                onClick={() => act('relabel')} />
            </Fragment>
          )}>
          <LabeledControls>
            <LabeledControls.Item
              minWidth="66px"
              label="Давление">
              <AnimatedNumber
                value={tankPressure}
                format={value => {
                  if (value < 10000) {
                    return toFixed(value) + ' кПа';
                  }
                  return formatSiUnit(value * 1000, 1, 'Па');
                }} />
            </LabeledControls.Item>
            <LabeledControls.Item label="Вентиль">
              <Box
                position="relative"
                left="-8px">
                <Knob
                  size={1.25}
                  color={!!valveOpen && 'yellow'}
                  value={releasePressure}
                  unit="кПа"
                  minValue={minReleasePressure}
                  maxValue={maxReleasePressure}
                  step={5}
                  stepPixelSize={1}
                  onDrag={(e, value) => act('pressure', {
                    pressure: value,
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="-2px"
                  right="-20px"
                  color="transparent"
                  icon="fast-forward"
                  onClick={() => act('pressure', {
                    pressure: maxReleasePressure,
                  })} />
                <Button
                  fluid
                  position="absolute"
                  top="16px"
                  right="-20px"
                  color="transparent"
                  icon="undo"
                  onClick={() => act('pressure', {
                    pressure: defaultReleasePressure,
                  })} />
              </Box>
            </LabeledControls.Item>
            <LabeledControls.Item label="Valve">
              <Button
                my={0.5}
                width="50px"
                lineHeight={2}
                fontSize="11px"
                color={valveOpen
                  ? (hasHoldingTank ? 'caution' : 'danger')
                  : null}
                content={valveOpen ? 'Открыт' : 'Закрыт'}
                onClick={() => act('valve')} />
            </LabeledControls.Item>
            <LabeledControls.Item
              mr={1}
              label="Порт">
              <Box position="relative">
                <Icon
                  size={1.25}
                  name={portConnected ? 'plug' : 'times'}
                  color={portConnected ? 'good' : 'bad'} />
                <Tooltip
                  content={portConnected
                    ? 'Подключён'
                    : 'Отключён'}
                  position="top" />
              </Box>
            </LabeledControls.Item>
          </LabeledControls>
        </Section>
        <Section
          title="Бак"
          buttons={!!hasHoldingTank && (
            <Button
              icon="eject"
              color={valveOpen && 'danger'}
              content="Изъять"
              onClick={() => act('eject')} />
          )}>
          {!!hasHoldingTank && (
            <LabeledList>
              <LabeledList.Item label="Метка">
                {holdingTank.name}
              </LabeledList.Item>
              <LabeledList.Item label="Давление">
                <AnimatedNumber value={holdingTank.tankPressure} /> кПа
              </LabeledList.Item>
            </LabeledList>
          )}
          {!hasHoldingTank && (
            <Box color="average">
              Внутри нет бака
            </Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
