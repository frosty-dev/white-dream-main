/* amoggers
/datum/ai_behavior/follow
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT
	required_distance = 2
	var/target_blackboard_key

/datum/ai_behavior/follow/perform(delta_time, datum/ai_controller/controller)
	. = ..()

	if(target_blackboard_key && controller.blackboard[target_blackboard_key])
		controller.current_movement_target = controller.blackboard[target_blackboard_key]
		finish_action(controller, TRUE)
		return
	finish_action(controller, FALSE)

*/
