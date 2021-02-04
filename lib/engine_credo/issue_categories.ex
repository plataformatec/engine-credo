defmodule EngineCredo.IssueCategories do
  @moduledoc """
  Mapping of categories from Credo to Code Climate.
  """
  @after_compile __MODULE__

  @lookup_table %{
    Credo.Check.Consistency.ExceptionNames => "Style",
    Credo.Check.Consistency.LineEndings => "Style",
    Credo.Check.Consistency.SpaceAroundOperators => "Style",
    Credo.Check.Consistency.SpaceInParentheses => "Style",
    Credo.Check.Consistency.TabsOrSpaces => "Style",
    Credo.Check.Consistency.ParameterPatternMatching => "Style",
    Credo.Check.Consistency.MultiAliasImportRequireUse => "Style",
    Credo.Check.Consistency.UnusedVariableNames => "Style",

    Credo.Check.Design.AliasUsage => "Clarity",
    Credo.Check.Design.DuplicatedCode => "Duplication",
    Credo.Check.Design.TagFIXME => "Bug Risk",
    Credo.Check.Design.TagTODO => "Bug Risk",

    Credo.Check.Readability.AliasOrder => "Style",
    Credo.Check.Readability.AliasAs => "Style",
    Credo.Check.Readability.FunctionNames => "Style",
    Credo.Check.Readability.LargeNumbers => "Style",
    Credo.Check.Readability.UnnecessaryAliasExpansion => "Style",
    Credo.Check.Readability.MaxLineLength => "Style",
    Credo.Check.Readability.MultiAlias => "Style",
    Credo.Check.Readability.ModuleAttributeNames => "Style",
    Credo.Check.Readability.ModuleDoc => "Clarity",
    Credo.Check.Readability.ModuleNames => "Style",
    Credo.Check.Readability.NoParenthesesWhenZeroArity => "Style",
    Credo.Check.Readability.ParenthesesInCondition => "Style",
    Credo.Check.Readability.ParenthesesOnZeroArityDefs => "Style",
    Credo.Check.Readability.PredicateFunctionNames => "Style",
    Credo.Check.Readability.PreferImplicitTry => "Style",
    Credo.Check.Readability.PreferUnquotedAtoms => "Style",
    Credo.Check.Readability.RedundantBlankLines => "Style",
    Credo.Check.Readability.Semicolons => "Style",
    Credo.Check.Readability.SinglePipe => "Style",
    Credo.Check.Readability.SpaceAfterCommas => "Style",
    Credo.Check.Readability.Specs => "Style",
    Credo.Check.Readability.StrictModuleLayout => "Style",
    Credo.Check.Readability.StringSigils => "Style",
    Credo.Check.Readability.TrailingBlankLine => "Style",
    Credo.Check.Readability.TrailingWhiteSpace => "Style",
    Credo.Check.Readability.VariableNames => "Style",
    Credo.Check.Readability.WithCustomTaggedTuple => "Clarity",

    Credo.Check.Refactor.ABCSize => "Complexity",
    Credo.Check.Refactor.CondStatements => "Complexity",
    Credo.Check.Refactor.CyclomaticComplexity => "Complexity",
    Credo.Check.Refactor.FunctionArity => "Complexity",
    Credo.Check.Refactor.MatchInCondition => "Complexity",
    Credo.Check.Refactor.ModuleDependencies => "Complexity",
    Credo.Check.Refactor.NegatedConditionsInUnless => "Style",
    Credo.Check.Refactor.NegatedConditionsWithElse => "Style",
    Credo.Check.Refactor.NegatedIsNil => "Style",
    Credo.Check.Refactor.Nesting => "Complexity",
    Credo.Check.Refactor.PerceivedComplexity => "Complexity",
    Credo.Check.Refactor.PipeChainStart => "Clarity",
    Credo.Check.Refactor.UnlessWithElse => "Style",
    Credo.Check.Refactor.DoubleBooleanNegation => "Style",
    Credo.Check.Refactor.VariableRebinding => "Clarity",
    Credo.Check.Refactor.AppendSingleItem => "Clarity",
    Credo.Check.Refactor.LongQuoteBlocks => "Clarity",
    Credo.Check.Refactor.MapInto => "Clarity",
    Credo.Check.Refactor.WithClauses => "Clarity",

    Credo.Check.Warning.UnsafeToAtom => "Bug Risk",
    Credo.Check.Warning.BoolOperationOnSameValues => "Bug Risk",
    Credo.Check.Warning.IExPry => "Bug Risk",
    Credo.Check.Warning.IoInspect => "Bug Risk",
    Credo.Check.Warning.OperationOnSameValues => "Bug Risk",
    Credo.Check.Warning.OperationWithConstantResult => "Clarity",
    Credo.Check.Warning.UnusedEnumOperation => "Bug Risk",
    Credo.Check.Warning.UnusedFileOperation => "Bug Risk",
    Credo.Check.Warning.UnusedKeywordOperation => "Bug Risk",
    Credo.Check.Warning.UnusedListOperation => "Bug Risk",
    Credo.Check.Warning.UnusedPathOperation => "Bug Risk",
    Credo.Check.Warning.UnusedRegexOperation => "Bug Risk",
    Credo.Check.Warning.UnusedStringOperation => "Bug Risk",
    Credo.Check.Warning.UnusedTupleOperation => "Bug Risk",
    Credo.Check.Warning.UnsafeExec => "Security",
    Credo.Check.Warning.LazyLogging => "Style",
    Credo.Check.Warning.LeakyEnvironment => "Security",
    Credo.Check.Warning.MapGetUnsafePass => "Bug Risk",
    Credo.Check.Warning.RaiseInsideRescue => "Clarity",
    Credo.Check.Warning.ExpensiveEmptyEnumCheck => "Complexity",
    Credo.Check.Warning.MixEnv => "Bug Risk",

    # Deprecated checks
    Credo.Check.Refactor.CaseTrivialMatches => "Clarity"
  }

  @helper_modules [
    Credo.Check.ConfigCommentFinder,
    Credo.Check.Design.TagHelper,
    Credo.Check.FindLintAttributes,
    Credo.Check.Warning.UnusedFunctionReturnHelper
  ]

  @doc """
  Get a list of Code Climate issue categories based on the given `Credo.Check`.

  Possible issue categories:

  * Bug Risk
  * Clarity
  * Compatibility
  * Complexity
  * Duplication
  * Performance
  * Security
  * Style
  """
  def for_check(credo_check), do: Map.fetch!(@lookup_table, credo_check)

  def __after_compile__(_env, _bytecode) do
    Application.load(:credo)
    modules = Application.spec(:credo, :modules)

    missing_checks =
    modules
    |> Enum.filter(&credo_check?/1)
    |> Kernel.--(@helper_modules)
    |> Kernel.--(Map.keys(@lookup_table))

    if Enum.any?(missing_checks) do
      raise "Missing category mapping for:\n * #{Enum.join(missing_checks, "\n * ")}."
    end
  end

  defp credo_check?(module) do
    Code.ensure_loaded?(module) && function_exported?(module, :category, 0)
  end
end
