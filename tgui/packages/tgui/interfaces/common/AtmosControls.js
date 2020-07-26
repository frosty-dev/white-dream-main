import { decodeHtmlEntities } from 'common/string';
import { useBackend, useLocalState } from '../../backend';
import { Box, Button, LabeledList, NumberInput, Section } from '../../components';
import { getGasLabel } from '../../constants';


export const Vent = (props, context) => {
  const { vent } = props;
  const { act } = useBackend(context);
  const {
    id_tag,
    long_name,
    power,
    checks,
    excheck,
    incheck,
    direction,
    external,
    internal,
    extdefault,
    intdefault,
  } = vent;
  return (
    <Section
      level={2}
      title={decodeHtmlEntities(long_name)}
      buttons={(
        <Button
          icon={power ? 'power-off' : 'times'}
          selected={power}
          content={power ? 'ВКЛ' : 'ВЫКЛ'}
          onClick={() => act('power', {
            id_tag,
            val: Number(!power),
          })} />
      )}>
      <LabeledList>
        <LabeledList.Item label="Режим">
          <Button
            icon="sign-in-alt"
            content={direction ? 'Наполнение' : 'Откачка'}
            color={!direction && 'danger'}
            onClick={() => act('direction', {
              id_tag,
              val: Number(!direction),
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Регулятор давления">
          <Button
            icon="sign-in-alt"
            content="Внутренний"
            selected={incheck}
            onClick={() => act('incheck', {
              id_tag,
              val: checks,
            })} />
          <Button
            icon="sign-out-alt"
            content="Внешний"
            selected={excheck}
            onClick={() => act('excheck', {
              id_tag,
              val: checks,
            })} />
        </LabeledList.Item>
        {!!incheck && (
          <LabeledList.Item label="Внутреннее целевое">
            <NumberInput
              value={Math.round(internal)}
              unit="кПа"
              width="75px"
              minValue={0}
              step={10}
              maxValue={5066}
              onChange={(e, value) => act('set_internal_pressure', {
                id_tag,
                value,
              })} />
            <Button
              icon="undo"
              disabled={intdefault}
              content="Сбросить"
              onClick={() => act('reset_internal_pressure', {
                id_tag,
              })} />
          </LabeledList.Item>
        )}
        {!!excheck && (
          <LabeledList.Item label="Внешнее целевое">
            <NumberInput
              value={Math.round(external)}
              unit="кПа"
              width="75px"
              minValue={0}
              step={10}
              maxValue={5066}
              onChange={(e, value) => act('set_external_pressure', {
                id_tag,
                value,
              })} />
            <Button
              icon="undo"
              disabled={extdefault}
              content="Сбросить"
              onClick={() => act('reset_external_pressure', {
                id_tag,
              })} />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};


export const Scrubber = (props, context) => {
  const { scrubber } = props;
  const { act } = useBackend(context);
  const {
    long_name,
    power,
    scrubbing,
    id_tag,
    widenet,
    filter_types,
  } = scrubber;
  return (
    <Section
      level={2}
      title={decodeHtmlEntities(long_name)}
      buttons={(
        <Button
          icon={power ? 'power-off' : 'times'}
          content={power ? 'ВКЛ' : 'ВЫКЛ'}
          selected={power}
          onClick={() => act('power', {
            id_tag,
            val: Number(!power),
          })} />
      )}>
      <LabeledList>
        <LabeledList.Item label="Режим">
          <Button
            icon={scrubbing ? 'filter' : 'sign-in-alt'}
            color={scrubbing || 'danger'}
            content={scrubbing ? 'Чистка' : 'Выкачивание'}
            onClick={() => act('scrubbing', {
              id_tag,
              val: Number(!scrubbing),
            })} />
          <Button
            icon={widenet ? 'expand' : 'compress'}
            selected={widenet}
            content={widenet ? 'Расширенный радиус' : 'Обычный радиус'}
            onClick={() => act('widenet', {
              id_tag,
              val: Number(!widenet),
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Фильтры">
          {scrubbing
            && filter_types.map(filter => (
              <Button key={filter.gas_id}
                icon={filter.enabled ? 'check-square-o' : 'square-o'}
                content={getGasLabel(filter.gas_id, filter.gas_name)}
                title={filter.gas_name}
                selected={filter.enabled}
                onClick={() => act('toggle_filter', {
                  id_tag,
                  val: filter.gas_id,
                })} />
            ))
            || 'N/A'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
