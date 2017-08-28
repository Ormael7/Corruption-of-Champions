/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts {
import classes.CoC;

import coc.script.Eval;

import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.StoryContext;

public class DynStatsStmt extends Statement{
	private var args:Object = {};
	public function DynStatsStmt() {
	}
	public function setAttr(attrname:String,expr:String):void {
		if (expr == null) delete args[expr];
		else args[attrname] = Eval.compile(expr);
	}

	override public function execute(context:ExecContext):void {
		var game:CoC = (context as StoryContext).game;
		var arr:Array = [];
		for (var name:String in args) {
			arr.push(name);
			arr.push((args[name] as Eval).vcall(context.scopes));
		}
		game.dynStats.apply(game,arr);
	}
}
}
