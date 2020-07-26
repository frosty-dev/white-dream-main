import { classes } from 'common/react';
import { useBackend } from '../backend';
import { Box, Button, Flex, Grid, Icon, Section } from '../components';
import { Window } from '../layouts';

export const Cellphone = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window theme="retro">
      <Window.Content>
        <Box width="252px" height="270px"
          className={classes(['Cellphone__bg'])}>
          <CellphoneStat />
          <CellphoneScreenSelector />
          <CellphoneFuncMenu />
        </Box>
        <Box width="252px" height="10px" />
        <CellphoneFunc />
        <CellphoneNumpad />
      </Window.Content>
    </Window>
  );
};

const CellphoneStat = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Box width="240px" height="20px" className={classes(['Cellphone__font'])}>
      🔋∞
    </Box>
  );
};

const CellphoneScreenSelector = (props, context) => {
  const { data } = useBackend(context);
  const screen = data.screen;
  return (
    <Box width="240px" height="212px"
      className={classes(['Cellphone__padding'])}>
      {screen === "main" && (<CScreenMain />)}
      {screen === "menu" && (<CScreenMenu />)}
    </Box>
  );
};

const CScreenMain = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Section height="210px" title="ShwainokarasOS v0.9.3">
      <Box height="200px"
        className="Cellphone__OSIcon" />
    </Section>
  );
};

const CScreenMenu = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Box align="center" className={classes(['Cellphone__font'])}>
      <Grid width="1px">
        {data.options.map((valC, keyC) => (
          <Grid.Column key={keyC}>
            {valC.map((val, key) => (
              <Box key={key} width="60px" height="60px">
                {(data.ptr_i-1) === keyC && (data.ptr_j-1) === key && (">")}
                {val[0]}
              </Box>
            ))}
          </Grid.Column>
        ))}
      </Grid>
    </Box>
  );
};

const CellphoneFuncMenu = (props, context) => {
  const { data } = useBackend(context);
  return (
    <Flex width="240px" height="30px" justify="space-between">
      <Flex.Item>
        {data.lf_menu && (
          <Section width="70px" height="30px" align="center">
            {data.lf_menu}
          </Section>)}
      </Flex.Item>
      <Flex.Item align="right">
        {data.rf_menu && (
          <Section width="70px" height="30px" align="center"
            className={classes(['Cellphone__fixrm'])}>
            {data.rf_menu}
          </Section>)}
      </Flex.Item>
    </Flex>
  );
};

const CellphoneNumpad = (props, context) => {
  const { act } = useBackend(context);
  const keypadKeys = [
    ['1', '4', '7', '*'],
    ['2', '5', '8', '0'],
    ['3', '6', '9', '#'],
  ];
  return (
    <Box width="240px">
      <Grid width="1px">
        {keypadKeys.map(keyColumn => (
          <Grid.Column key={keyColumn[0]}>
            {keyColumn.map(key => (
              <Button
                fluid
                bold
                key={key}
                mb={1}
                content={key}
                textAlign="center"
                fontSize="20px"
                lineHeight="20px"
                width="80px"
                className={classes([
                  'Cellphone__Button',
                  'Cellphone__Button--keypad',
                ])}
                onClick={() => act('numpad', { digit: key })} />
            ))}
          </Grid.Column>
        ))}
      </Grid>
    </Box>
  );
};

const CellphoneFunc = (props, context) => {
  const { act } = useBackend(context);
  return (
    <Box width="252px">
      <Flex justify="space-between">
        <Flex.Item>
          <Button fluid bold content="📞"
            textAlign="center" fontSize="30px"
            lineHeight="35px" width="55px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('call')} />

          <Button fluid bold content="➥"
            textAlign="center" fontSize="30px"
            lineHeight="35px" width="55px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('leftfunc')} />
        </Flex.Item>

        <Flex.Item align="center">
          <Button fluid bold content="◀"
            textAlign="center" fontSize="20px"
            lineHeight="60px" width="20px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('dpad', { button: "larrow" })} />
        </Flex.Item>

        <Flex.Item >
          <Button fluid bold content="▲"
            textAlign="center" fontSize="20px"
            lineHeight="20px" width="50px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('dpad', { button: "uarrow" })} />

          <Button fluid bold content="⎆"
            textAlign="center" fontSize="20px"
            lineHeight="20px" width="50px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('dpad', { button: "enter" })} />

          <Button fluid bold content="▼"
            textAlign="center" fontSize="20px"
            lineHeight="20px" width="50px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('dpad', { button: "darrow" })} />
        </Flex.Item>

        <Flex.Item align="center">
          <Button fluid bold content="▶"
            textAlign="center" fontSize="20px"
            lineHeight="60px" width="20px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('dpad', { button: "rarrow" })} />
        </Flex.Item>

        <Flex.Item>
          <Button fluid bold content="📴"
            textAlign="center" fontSize="20px"
            lineHeight="35px" width="55px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('hang')} />

          <Button fluid bold content="➈"
            textAlign="center" fontSize="20px"
            lineHeight="35px" width="55px"
            className={classes([
              'Cellphone__Button',
              'Cellphone__Button--keypad',
            ])}
            onClick={() => act('rightfunc')} />
        </Flex.Item>

      </Flex>
    </Box>
  );
};
