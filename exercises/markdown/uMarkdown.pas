unit uMarkdown;

interface

uses Generics.Collections;

type

  IMarkDownRule = interface
    function Parse(input : string) : string;
  end;

  TParagraphMarkDown = class(TInterfacedObject,IMarkDownRule)
  public
    function Parse(input : string) : string;
  end;

  TItalicMarkDown = class(TInterfacedObject, IMarkDownrule)
    function Parse(input : string) : string;
  end;

  TBoldMarkDown = class(TInterfacedObject, IMarkDownrule)
    function Parse(input : string) : string;
  end;


  TH1Markdown = class(TInterfacedObject, IMarkDownRule)
    function Parse(input : string) : string;
  end;

  TH2Markdown = class(TInterfacedObject, IMarkDownRule)
    function Parse(input : string) : string;
  end;

  TH6Markdown = class(TInterfacedObject, IMarkDownRule)
    function Parse(input : string) : string;
  end;

  TUnorderedListMarkdown = class(TInterfacedObject, IMarkDownRule)
    function Parse(input : string) : string;
  end;

  TMarkdown = class
  private
    RuleList : TList<IMarkDownRule>;
  public
    constructor Create;
    function Parse(input : string) : string;
  end;

implementation

uses
  System.SysUtils, RegularExpressions ;

{ TMarkdown }

constructor TMarkdown.Create;
begin
  RuleList := TList<IMarkDownRule>.Create;

  RuleList.Add(TH1MarkDown.create);
  RuleList.Add(TH2MarkDown.create);
  RuleList.Add(TH6MarkDown.create);
  RuleList.Add(TUnorderedListMarkdown.create);
  RuleList.Add(TParagraphMarkDown.create);
  RuleList.Add(TBoldMarkDown.create);
  RuleList.Add(TItalicMarkDown.create);

end;

function TMarkdown.Parse(input: string): string;
var
  EndResult : string;
  Rule : IMarkDownRule;
begin
  EndResult := input;
  for Rule in RuleList do
  begin
    EndResult := Rule.Parse(EndResult);
  end;
  Result := EndResult;
end;

{ BoldMarkDown }

function TParagraphMarkDown.Parse(input: string): string;
var
  Regex : TRegEx;
begin
  Regex := TRegEx.Create('^<h[1-6]>|<ul');
  if not Regex.IsMatch(input) then
    Result := format('<p>%s</p>',[input]);
end;

{ TItalicMarkDown }

function TItalicMarkDown.Parse(input: string): string;
var
  Regex : TRegEx;
begin
  Regex := TRegEx.Create('_([^_]*)_');
  Result := Regex.Replace(input, '<em>$+</em>');
end;

{ TBoldMarkDown }

function TBoldMarkDown.Parse(input: string): string;
var
  Regex : TRegEx;
begin
  Regex := TRegEx.Create('__([^__]*)__');
  Result := Regex.Replace(input, '<strong>$+</strong>');
end;

{ TH1Markdown }

function TH1Markdown.Parse(input: string): string;
var
  Regex : TRegEx;
begin
  Regex := TRegEx.Create('^# (.*)');
  Result := Regex.Replace(input, '<h1>$+</h1>');
end;

{ TH2Markdown }

function TH2Markdown.Parse(input: string): string;
var
  Regex : TRegEx;
begin
  Regex := TRegEx.Create('^## (.*)');
  Result := Regex.Replace(input, '<h2>$+</h2>');
end;

{ TH6Markdown }

function TH6Markdown.Parse(input: string): string;
var
  Regex : TRegEx;
begin
  Regex := TRegEx.Create('^###### (.*)');
  Result := Regex.Replace(input, '<h6>$+</h6>');
end;

{ TUnorderedListMarkdown }

function TUnorderedListMarkdown.Parse(input: string): string;
var
  Regex : TRegEx;
  RegexReplace : string;
  MAtch: TObject;
begin
  Regex := TRegEx.Create('(\* ([^\\n\*|\\n]*))*');
  if Regex.IsMatch(input) then
  begin
    RegexReplace := Regex.Replace(input, '<li>$+</li>');
    Regex := TRegEx.Create('<li>([^<li>]*)</li>');
    for Match in Regex.Matches(RegexReplace) do
    begin

    end;
    Result := RegEx.Escape Replace(RegexReplace,'<ul>$&</ul>');
  end
  else Exit(input);
end;

end.
