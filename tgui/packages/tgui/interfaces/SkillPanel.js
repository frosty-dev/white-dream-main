import { useBackend } from '../backend';
import { Box, Button, LabeledList, ProgressBar, Section } from '../components';
import { Window } from '../layouts';
const skillgreen = {
  color: 'lightgreen',
  fontWeight: 'bold',
};
const skillyellow = {
  color: '#FFDB58',
  fontWeight: 'bold',
};
export const SkillPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const skills = data.skills || [];
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title={skills.playername}>
          <LabeledList>
            {skills.map(skill => (
              <LabeledList.Item key={skill.name} label={skill.name}>
                <span style={skillyellow}>
                  {skill.desc}
                </span>
                <br />
                <Level skill_lvl_num={skill.lvlnum} skill_lvl={skill.lvl} />
                <br />
                Всего опыта: [{skill.exp} XP]
                <br />
                XP до следующего уровня: 
                {skill.exp_req !== 0 ? (
                  <span>
                    [{skill.exp_prog} / {skill.exp_req}]
                  </span>
                ) : (
                  <span style={skillgreen}>
                    [МАКСИМУМ]
                  </span>
                )}
                <br />
                Общий прогресс: [{skill.exp} / {skill.max_exp}]
                <ProgressBar
                  value={skill.exp_percent}
                  color="good" />
                <br />
                <Button
                  content="Настроить"
                  onClick={() => act('adj_exp', {
                    skill: skill.path,
                  })} />
                <Button
                  content="Выставить"
                  onClick={() => act('set_exp', {
                    skill: skill.path,
                  })} />
                <Button
                  content="Уровень"
                  onClick={() => act('set_lvl', {
                    skill: skill.path,
                  })} />
                <br />
                <br />
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
const Level = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    skill_lvl_num,
    skill_lvl,
  } = props;
  let textstyle="font-weight:bold; color:hsl("+skill_lvl_num*50+", 50%, 50%)";
  return (
    <span>Уровень: [<span style={textstyle}>{skill_lvl}</span>]</span>
  );
};
const XPToNextLevel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    xp_req,
    xp_prog,
  } = props;
  if (xp_req === 0) {
    return (
      <span style={skillgreen}>
        до следующего уровня: МАКСИМУМ
      </span>
    );
  }
  return (
    <span>XP до следующего уровня: [{xp_prog} / {xp_req}]</span>
  );
};
