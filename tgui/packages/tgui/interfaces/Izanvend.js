import { map } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { AnimatedNumber, Box, Button, LabeledList, Section, Tabs } from '../components';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

export const Izanvend = (props, context) => {
  const { state } = props;
  const { config, data } = state;
  const { ref } = config;
  const products = data.products || {};

  return (
    <Fragment>
      <Section title="ИзанВендор">
        Лучшие товары со всех помоек!
      </Section>
      <Tabs mt={2}>
        <Tabs.Tab
          key="catalog"
          label="Каталог"
          icon="list"
          lineHeight="23px">
          {() => (
            <Section title="Каталог">
              <Catalog state={state} products={products} />
            </Section>
          )}
        </Tabs.Tab>
      </Tabs>
    </Fragment>
  );
};

const Catalog = (props, context) => {
  const { act, data } = useBackend(context);
  const { state, products } = props;
  const { config } = state;
  const { ref } = config;
  const renderTab = key => {
    const supply = products[key];
    const packs = supply.packs;
    return (
      <table className="LabeledList">
        {packs.map(pack => (
          <tr
            key={pack.name}
            className="LabeledList__row candystripe">
            <td className="LabeledList__cell LabeledList__label">
              {pack.name}
            </td>
            <td className="LabeledList__cell LabeledList__buttons">
              <Button fluid
                content="Получить"
                onClick={() => act('vend', {
                  product_path: pack.product_path,
                })} />
            </td>
          </tr>
        ))}
      </table>
    );
  };
  return (
    <Tabs vertical>
      {map(supply => {
        const name = supply.name;
        return (
          <Tabs.Tab key={name} label={name}>
            {renderTab}
          </Tabs.Tab>
        );
      })(products)}
    </Tabs>
  );
};
