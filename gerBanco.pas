unit gerBanco;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Bde.DBTables;

type
  Tbanco = class(TDataModule)
    con_banco: TFDConnection;
  private
    { Private declarations }
  public
    function getGenerator(sGenerator:string; iIncremento:integer = 1) : Integer;
    { Public declarations }
  end;

var
  banco: Tbanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tbanco }

function Tbanco.getGenerator(sGenerator: string; iIncremento: integer = 1): Integer;
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := banco.con_banco;
    qry.SQL.Add('SELECT GEN_ID('+sGenerator+', '+IntToStr(iIncremento)+') AS SEQ FROM RDB$DATABASE');
    qry.Open;

    Result := qry.FieldByName('SEQ').AsInteger;
  finally
    qry.Free;
  end;
end;

end.
