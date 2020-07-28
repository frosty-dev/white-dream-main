import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, Input, Section } from '../components';
import { Window } from '../layouts';


export const MapWindow = (props, context) => {
  const { act, data, config } = useBackend(context);

  return (
    <Window
      width={350}
      height={350}>
      <Window.Content>
        <ByondUi
          params={{
            id: data.mapRef,
            parent: config.window,
            type: 'map',
          }} />
      </Window.Content>
    </Window>
  );
};
