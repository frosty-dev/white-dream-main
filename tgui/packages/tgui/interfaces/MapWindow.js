import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, Input, Section } from '../components';
import { Window } from '../layouts';


export const MapWindow = (props, context) => {
  const { act, data, config } = useBackend(context);

  return (
    <Window>
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
