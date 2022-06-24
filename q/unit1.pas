unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ExtCtrls, Buttons;

type
iitems = record
ddate: string[10];
nname: string[40];
opis: string[100];
price: string[10]
end; //record



  { TfMain }

  TfMain = class(TForm)
    Panel1: TPanel;
    SG: TStringGrid;
    bAdd: TSpeedButton;
    bDel: TSpeedButton;
    bEdit: TSpeedButton;
    procedure bAddClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  s:string;
implementation
uses unit2;

{$R *.lfm}

{ TfMain }

procedure TfMain.FormCreate(Sender: TObject);
var
q: iitems;
f: file of iitems;
i: integer;
begin
s:= ExtractFilePath(ParamStr(0));
SG.Cells[0, 0]:= 'Дата';
SG.Cells[1, 0]:= 'Наименование';
SG.Cells[2, 0]:= 'Описание';
SG.Cells[3, 0]:= 'Цена';
SG.ColWidths[0]:= 50;
SG.ColWidths[1]:= 150;
SG.ColWidths[2]:= 150;
SG.ColWidths[3]:= 150;
if not FileExists(s + 'tex.txt') then exit;
try
AssignFile(f,'spisok.dat');
Reset(f);
while not Eof(f) do begin
Read(f, q);
SG.RowCount:= SG.RowCount + 1;
SG.Cells[0, SG.RowCount-1]:= q.ddate;
SG.Cells[1, SG.RowCount-1]:= q.nname;
SG.Cells[2, SG.RowCount-1]:= q.opis;
SG.Cells[2, SG.RowCount-1]:= q.price;
end;
finally
CloseFile(f);
end;
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
begin
fEdit.ddate.Text:= '';
fEdit.nname.Text:= '';
fEdit.ModalResult:= mrNone;
fEdit.ShowModal;
if (fEdit.ddate.Text= '') or (fEdit.nname.Text= '') then exit;
if fEdit.ModalResult <> mrOk then exit;
SG.RowCount:= SG.RowCount + 1;
SG.Cells[0, SG.RowCount-1]:= fEdit.ddate.Text;
SG.Cells[1, SG.RowCount-1]:= fEdit.nname.Text;
SG.Cells[2, SG.RowCount-1]:= fEdit.opis.Text;
SG.Cells[3, SG.RowCount-1]:= fEdit.price.Text;
end;

end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
q: iitems;
f: file of iitems;
i: integer;
begin
if SG.RowCount = 1 then exit;
try
AssignFile(f, 'spisok.dat');
Rewrite(f);
for i:= 1 to SG.RowCount-1 do begin
q.ddate:= SG.Cells[0, i];
q.nname:= SG.Cells[1, i];
q.opis:= SG.Cells[2, i];
q.price:= SG.Cells[3, i];
Write(f, q);
end;
finally
CloseFile(f);
end;

end;

procedure TfMain.bAddClick(Sender: TObject);
begin
  fEdit.ddate.Text:= '';
  fEdit.nname.Text:= '';
  fEdit.ModalResult:= mrNone;
  fEdit.ShowModal;
  if (fEdit.ddate.Text= '') or (fEdit.nname.Text= '') then exit;
  if fEdit.ModalResult <> mrOk then exit;
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1]:= fEdit.ddate.Text;
  SG.Cells[1, SG.RowCount-1]:= fEdit.nname.Text;
  SG.Cells[2, SG.RowCount-1]:= fEdit.opis.Text;
  SG.Cells[3, SG.RowCount-1]:= fEdit.price.Text;
  end;

procedure TfMain.bDelClick(Sender: TObject);
begin
if SG.RowCount = 1 then exit;
if MessageDlg('Требуется подтверждение','Вы действительно хотите удалить данные "'
+ SG.Cells[0, SG.Row] + '"?', mtConfirmation, [mbYes, mbNo, mbIgnore], 0) = mrYes then
SG.DeleteRow(SG.Row);
end;

procedure TfMain.bEditClick(Sender: TObject);
begin
if SG.RowCount = 1 then exit;
fEdit.ddate.Text:= SG.Cells[0, SG.Row];
fEdit.nname.Text:= SG.Cells[1, SG.Row];
fEdit.opis.Text:= SG.Cells[2, SG.Row];
fEdit.price.Text:= SG.Cells[3, SG.Row];
fEdit.ModalResult:= mrNone;
fEdit.ShowModal;
if fEdit.ModalResult = mrOk then begin
SG.Cells[0, SG.Row]:= fEdit.ddate.Text;
SG.Cells[1, SG.Row]:= fEdit.nname.Text;
SG.Cells[2, SG.Row]:= fEdit.opis.Text;
SG.Cells[3, SG.Row]:= fEdit.price.Text;
end;

end;

procedure TfMain.bSortClick(Sender: TObject);
begin
if SG.RowCount = 1 then exit;
SG.SortColRow(true, 0);
end;
end.

