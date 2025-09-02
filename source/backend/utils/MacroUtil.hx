package backend.utils;

/**
	Collection of various utility macros
**/
class MacroUtil
{
    /**
        Converts abstract classes to ones usable in HScript.

        Stolen from NightmareVision btw - https://github.com/DuskieWhy/NightmareVision/blob/main/source/funkin/utils/MacroUtil.hx

        @param typePath Type to convert
        @param exclude (Optional) String array of fields that should be excluded
    **/
	public static macro function buildAbstract(typePath:Expr, ?exclude:Array<String>)
	{
		var type = Context.getType(typePath.toString());
		var expressions:Array<ObjectField> = [];

		if (exclude == null)
			exclude = ["NONE"];

		switch (type.follow())
		{
			case TAbstract(_.get() => ab, _):
				for (f in ab.impl.get().statics.get())
				{
					switch (f.kind)
					{
						case FVar(AccInline, _):
							switch (f.expr().expr)
							{
								case TCast(Context.getTypedExpr(_) => expr, _):
									if (f.name.toUpperCase() == f.name && exclude.indexOf(f.name) == -1) // uppercase?
									{
										expressions.push({field: f.name, expr: expr});
									}

								default:
							}

						default:
					}
				}
			default:
		}

		var finalResult = {expr: EObjectDecl(expressions), pos: Context.currentPos()};
		return macro $b{[macro $finalResult]};
	}
}
