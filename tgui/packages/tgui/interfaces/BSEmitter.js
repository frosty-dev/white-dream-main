import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Section, Tabs, NoticeBox } from '../components';
import { Window } from '../layouts';

export const BSEmitter = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window
      width={500}
      height={500}
      resizable>
      <Window.Content>
        <Section
          title="Эмиттер"
          buttons={(
            <Fragment>
              <Button
                icon={data.active ? 'times' : 'power-off'}
                content={data.active ? 'Отключить' : 'Включить'}
                disabled={data.expanding}
                onClick={() => act('toggle')} />
              <Button
                icon="sync"
                content="Переподключить"
                onClick={() => act('reconnect')} />
            </Fragment>
          )}>
          {data.connected ? (
            <LabeledList>
              <LabeledList.Item label="Портал">
                {data.active
                  ?(!data.expanding ? "Открыт":"Открывается")
                  :"Закрыт"}
              </LabeledList.Item>
              <LabeledList.Item label="Радиус портала">
                <NumberInput
                  value={data.radius}
                  width="59px"
                  minValue={1}
                  maxValue={16}
                  step={1}
                  stepPixelSize={10}
                  onChange={(e, value) => act('setRadius', {
                    radius: value,
                  })} />
              </LabeledList.Item>
              <LabeledList.Item label="X">
                <NumberInput
                  value={data.t_x}
                  width="59px"
                  minValue={0}
                  maxValue={255}
                  step={1}
                  stepPixelSize={4}
                  onChange={(e, value) => act('setCoords', {
                    newx: value,
                    newy: data.t_y,
                    newz: data.t_z,
                  })} />
              </LabeledList.Item>
              <LabeledList.Item label="Y">
                <NumberInput
                  value={data.t_y}
                  width="59px"
                  minValue={0}
                  maxValue={255}
                  step={1}
                  stepPixelSize={4}
                  onChange={(e, value) => act('setCoords', {
                    newx: data.t_x,
                    newy: value,
                    newz: data.t_z,
                  })} />
              </LabeledList.Item>

            </LabeledList>
          ) : (
            <NoticeBox textAlign="center">
              Эмиттер не обнаружен
            </NoticeBox>
          )}
        </Section>
        {!data.connected || (
          <Section title="Энергосеть">
            <LabeledList>
              <LabeledList.Item label="Подключение к сети">
                {data.powernet ? "Зарегистрировано" : "Отсутствует"}
              </LabeledList.Item>
            </LabeledList>

            {data.powernet ? (
              <LabeledList>
                <LabeledList.Item label="Мощность сети">
                  {data.surplusKW} KW
                </LabeledList.Item>

                <LabeledList.Item label="Нагрузка">
                  {data.loadKW} KW
                </LabeledList.Item>
              </LabeledList>
            ) : (
              <NoticeBox textAlign="center">
                Необходимо подключение к энергосети
              </NoticeBox>
            )}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
