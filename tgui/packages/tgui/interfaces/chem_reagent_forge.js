import { Window } from '../layouts';
import { Section, LabeledList, ProgressBar, Button } from "../components";
import { useBackend } from '../backend';

export const chem_reagent_forge = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    recipes,
    currently_forging,
    material_amount,
    can_afford,
    name,
    category,
    cost,
  } = data;
  return (
    <Window>
      <Window.Content>
        <Section
          title="Кузница">
          <LabeledList>
            <LabeledList.Item
              label={currently_forging} />
            <ProgressBar
              value={material_amount} />
            <div>
              <Button
                content="Eject"
                icon="Dump"
                disabled={currently_forging}
                OnClick={() => act("Dump")} />
            </div>
          </LabeledList>
        </Section>
        <Section
          title="Рецепты">
          <div display tabular>
            <Section candystripe>
              <Section cell bold>
                Recipe
              </Section>
              <Section cell bold>
                Cost (Cm3)
              </Section>
              <Section cell bold>
                Type
              </Section>
              <Section cell bold
                align="center">
                Create
              </Section>
            </Section>
            {recipes}
            <Section candystripe>
              <Section cell>
                {name}
              </Section>
              <Section cell
                align="right">
                {cost}
              </Section>
              <Section cell
                align="right">
                {category}
              </Section>
              <Section table
                alight="right" />
              <Section cell />
              <Section cell />
              <Section cell>
                <Button
                  disabled={can_afford}
                  OnClick={() => act('create', {
                    name: "name" })}>
                  Create
                </Button>
              </Section>
            </Section>
          </div>
        </Section>
      </Window.Content>
    </Window>
  );
};
