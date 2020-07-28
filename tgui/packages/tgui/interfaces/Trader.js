import { toArray } from 'common/collections';
import { Fragment } from 'inferno';
import { useBackend, useSharedState } from '../backend';
import { AnimatedNumber, Box, Button, Flex, LabeledList, Section, Table, Tabs } from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';

export const Trader = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useSharedState(context, 'tab', 'catalog');
  const {
    requestonly,
  } = data;
  const cart = data.cart || [];
  const requests = data.requests || [];
  return (
    <Window
      width={780}
      height={750}
      resizable>
      <Window.Content scrollable>
        <Status />
        <Tabs>
          <Tabs.Tab
            icon="list"
            selected={tab === 'catalog'}
            onClick={() => setTab('catalog')}>
            Каталог
          </Tabs.Tab>
          {!requestonly && (
            <Tabs.Tab
              icon="shopping-cart"
              textColor={tab !== 'cart'
                && cart.length > 0
                && 'yellow'}
              selected={tab === 'cart'}
              onClick={() => setTab('cart')}>
              Покупка ({cart.length})
            </Tabs.Tab>
          )}
        </Tabs>
        {tab === 'catalog' && (
          <Catalog />
        )}
        {tab === 'cart' && (
          <Cart />
        )}
      </Window.Content>
    </Window>
  );
};

const Status = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    away,
    docked,
    loan,
    loan_dispatched,
    location,
    message,
    points,
    requestonly,
  } = data;
  return (
    <Section
      title="Торговая зона"
      buttons={(
        <Box inline bold>
          <AnimatedNumber
            value={points}
            format={value => formatMoney(value)} />
          {' кредитов'}
        </Box>
      )}>
      <LabeledList>
        <LabeledList.Item label="Сообщение">
          {message}
        </LabeledList.Item>
        <LabeledList.Item label="Торговля">
          <Button
            content="Купить"
            onClick={() => act('buy')} />
          <Button
            content="Продать"
            onClick={() => act('sell')} />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

export const Catalog = (props, context) => {
  const { express } = props;
  const { act, data } = useBackend(context);
  const {
    self_paid,
  } = data;
  const supplies = toArray(data.supplies);
  const [
    activeSupplyName,
    setActiveSupplyName,
  ] = useSharedState(context, 'supply', supplies[0]?.name);
  const activeSupply = supplies.find(supply => {
    return supply.name === activeSupplyName;
  });
  return (
    <Section title="Каталог">
      <Flex>
        <Flex.Item>
          <Tabs vertical>
            {supplies.map(supply => (
              <Tabs.Tab
                key={supply.name}
                selected={supply.name === activeSupplyName}
                onClick={() => setActiveSupplyName(supply.name)}>
                {supply.name} ({supply.packs.length})
              </Tabs.Tab>
            ))}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          <Table>
            {activeSupply?.packs.map(pack => {
              const tags = [];
              if (pack.small_item) {
                tags.push('Небольшой');
              }
              if (pack.access) {
                tags.push('Защищённый');
              }
              return (
                <Table.Row
                  key={pack.name}
                  className="candystripe">
                  <Table.Cell>
                    {pack.name}
                  </Table.Cell>
                  <Table.Cell
                    collapsing
                    color="label"
                    textAlign="right">
                    {tags.join(', ')}
                  </Table.Cell>
                  <Table.Cell
                    collapsing
                    textAlign="right">
                    <Button
                      fluid
                      tooltip={pack.desc}
                      tooltipPosition="left"
                      onClick={() => act('add', {
                        id: pack.id,
                      })}>
                      {formatMoney(self_paid
                        ? Math.round(pack.cost * 1.1)
                        : pack.cost)}
                      {' cr'}
                    </Button>
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const CartButtons = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    requestonly,
  } = data;
  const cart = data.cart || [];
  const total = cart.reduce((total, entry) => total + entry.cost, 0);
  if (requestonly) {
    return null;
  }
  return (
    <Fragment>
      <Box inline mx={1}>
        {cart.length === 0 && 'Корзина пуста'}
        {cart.length === 1 && '1 заказ'}
        {cart.length >= 2 && cart.length + ' заказов'}
        {' '}
        {total > 0 && `(${formatMoney(total)} кредитов)`}
      </Box>
      <Button
        icon="times"
        color="transparent"
        content="Очистить"
        onClick={() => act('clear')} />
    </Fragment>
  );
};

const Cart = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    requestonly,
    away,
    docked,
    location,
  } = data;
  const cart = data.cart || [];
  return (
    <Section
      title="Текущая корзина"
      buttons={(
        <CartButtons />
      )}>
      {cart.length === 0 && (
        <Box color="label">
          Корзина пуста
        </Box>
      )}
      {cart.length > 0 && (
        <Table>
          {cart.map(entry => (
            <Table.Row
              key={entry.id}
              className="candystripe">
              <Table.Cell collapsing color="label">
                #{entry.id}
              </Table.Cell>
              <Table.Cell>
                {entry.object}
              </Table.Cell>
              <Table.Cell collapsing>
                {!!entry.paid && (
                  <b>[Оплачено с карты]</b>
                )}
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                {formatMoney(entry.cost)} кредитов
              </Table.Cell>
              <Table.Cell collapsing>
                <Button
                  icon="minus"
                  onClick={() => act('remove', {
                    id: entry.id,
                  })} />
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      )}
      {cart.length > 0 && !requestonly && (
        <Box mt={2}>
          {away === 1 && docked === 1 && (
            <Button
              color="green"
              style={{
                'line-height': '28px',
                'padding': '0 12px',
              }}
              content="Подтвердить заказ"
              onClick={() => act('send')} />
          )}
        </Box>
      )}
    </Section>
  );
};
