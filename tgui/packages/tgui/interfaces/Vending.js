import { classes } from 'common/react';
import { useBackend } from '../backend';
import { Box, Button, Section, Table } from '../components';
import { Window } from '../layouts';

const VendingRow = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    product,
    productStock,
    custom,
  } = props;
  const free = (
    !data.onstation
    || product.price === 0
    || (
      !product.premium
      && data.department
      && data.user
      && data.department === data.user.department
    )
  );
  return (
    <Table.Row>
      <Table.Cell collapsing>
        {product.img ? (
          <img
            src={`data:image/jpeg;base64,${product.img}`}
            style={{
              'vertical-align': 'middle',
              'horizontal-align': 'middle',
            }} />
        ) : (
          <span
            className={classes([
              'vending32x32',
              product.path,
            ])}
            style={{
              'vertical-align': 'middle',
              'horizontal-align': 'middle',
            }} />
        )}
      </Table.Cell>
      <Table.Cell bold>
        {product.name}
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        <Box
          color={custom
            ? 'good'
            : productStock <= 0
              ? 'bad'
              : productStock <= (product.max_amount / 2)
                ? 'average'
                : 'good'}>
          {productStock} шт.
        </Box>
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {custom && (
          <Button
            fluid
            content={data.access ? 'БЕСПЛАТНО' : product.price + ' кр'}
            onClick={() => act('dispense', {
              'item': product.name,
            })} />
        ) || (
          <Button
            fluid
            disabled={(
              productStock === 0
              || !free && (
                !data.user
                || product.price > data.user.cash
              )
            )}
            content={free ? 'БЕСПЛАТНО' : product.price + ' кр'}
            onClick={() => act('vend', {
              'ref': product.ref,
            })} />
        )}
      </Table.Cell>
    </Table.Row>
  );
};

export const Vending = (props, context) => {
  const { act, data } = useBackend(context);
  let inventory;
  let custom = false;
  if (data.vending_machine_input) {
    inventory = data.vending_machine_input;
    custom = true;
  } else if (data.extended_inventory) {
    inventory = [
      ...data.product_records,
      ...data.coin_records,
      ...data.hidden_records,
    ];
  } else {
    inventory = [
      ...data.product_records,
      ...data.coin_records,
    ];
  }
  return (
    <Window resizable>
      <Window.Content scrollable>
        {!!data.onstation && (
          <Section title="Пользователь">
            {data.user && (
              <Box>
                Здравствуйте, <b>{data.user.name}</b>,
                {' '}
                <b>{data.user.job || 'Безработный'}</b>!
                <br />
                Ваш баланс: <b>{data.user.cash} кредитов</b>.
              </Box>
            ) || (
              <Box color="light-gray">
                Нет ID-карты!<br />
                Свяжитесь с вашим местным отделом кадров!
              </Box>
            )}
          </Section>
        )}
        <Section title="Товары" >
          <Table>
            {inventory.map(product => (
              <VendingRow
                key={product.name}
                custom={custom}
                product={product}
                productStock={data.stock[product.name]} />
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
