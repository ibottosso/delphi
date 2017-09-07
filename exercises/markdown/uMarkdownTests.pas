unit uMarkdownTests;

interface

uses
  DUnitX.TestFramework,
  uMarkdown;

type

  [TestFixture]
  TMarkdownTests = class(TObject)
  private
    Markdown : TMarkdown;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure Teardown;
    [Test]
    procedure Parses_normal_text_as_a_paragraph;
    [Test]
    procedure Parsing_italics;
    [Test]
    procedure Parsing_bold_text;
    [Test]
    procedure Mixed_normal_italics_and_bold_text;
    [Test]
    procedure With_h1_header_level;
    [Test]
    procedure With_h2_header_leve;
    [Test]
    procedure With_h6_header_level;
    [Test]
    procedure Unordered_lists;
    [Test]
    procedure With_a_little_bit_of_everything;
  end;

implementation

uses
  System.SysUtils;


{ TMarkdownTests }

procedure TMarkdownTests.Setup;
begin
  Markdown := TMarkdown.Create;
end;

procedure TMarkdownTests.Teardown;
begin
  FreeAndNil(Markdown);
end;

procedure TMarkdownTests.Parses_normal_text_as_a_paragraph;
var
  Input, expected: string;
begin
  Input := 'This will be a paragraph';
  expected := '<p>This will be a paragraph</p>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.Parsing_italics;
var
  Input, expected: string;
begin
  Input := '_This will be italic_';
  expected := '<p><em>This will be italic</em></p>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.Parsing_bold_text;
var
  Input, expected: string;
begin
  Input := '__This will be bold__';
  expected := '<p><strong>This will be bold</strong></p>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.Mixed_normal_italics_and_bold_text;
var
  Input, expected: string;
begin
  Input := 'This will _be_ __mixed__';
  expected := '<p>This will <em>be</em> <strong>mixed</strong></p>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.With_h1_header_level;
var
  Input, expected: string;
begin
  Input := '# This will be an h1';
  expected := '<h1>This will be an h1</h1>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.With_h2_header_leve;
var
  Input, expected: string;
begin
  Input := '## This will be an h2';
  expected := '<h2>This will be an h2</h2>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.With_h6_header_level;
var
  Input, expected: string;
begin
  Input := '###### This will be an h6';
  expected := '<h6>This will be an h6</h6>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.Unordered_lists;
var
  Input, expected: string;
begin
  Input := '* Item 1\n* Item 2';
  expected := '<ul><li>Item 1</li><li>Item 2</li></ul>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;

procedure TMarkdownTests.With_a_little_bit_of_everything;
var
  Input, expected: string;
begin
  Input := '# Header!\n* __Bold Item__\n* _Italic Item_';
  expected := '<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>';
  Assert.AreEqual(expected, Markdown.Parse(Input));
end;



initialization

TDUnitX.RegisterTestFixture(TMarkdownTests);

end.
