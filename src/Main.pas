unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvPanel,
  Vcl.ExtCtrls, ToolPanels, Vcl.StdCtrls, AdvLabel, AdvGrid, AsgLinks, AdvEdit,
  AdvEdBtn, Vcl.Mask, RzEdit, RzPanel, RzRadGrp, RzButton, RzRadChk, AeroButtons,
  RzLabel, RzCmboBx, System.Hash, IdHashMessageDigest, Vcl.Clipbrd, Vcl.ComCtrls,
  System.Math;

type
  TPrincipal = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    AdvLabel1: TAdvLabel;
    lblTamSenha: TAdvLabel;
    cbMaius: TRzCheckBox;
    RzPanel1: TRzPanel;
    cbMinus: TRzCheckBox;
    cbNums: TRzCheckBox;
    cbEspecis: TRzCheckBox;
    cbEvitarAmbiguos: TRzCheckBox;
    cbCopiarAuto: TRzCheckBox;
    btnGerar: TAeroButton;
    cbHashQuest: TRzCheckBox;
    pnlHash: TRzPanel;
    RzLabel1: TRzLabel;
    edtSemente: TRzEdit;
    lblMaxSenha: TRzLabel;
    edtMaxSenha: TRzEdit;
    cbTamanhoSenha: TRzComboBox;
    edtSenha: TRzEdit;
    RzLabel2: TRzLabel;
    AdvLabel3: TAdvLabel;
    memSenhaGerada: TMemo;
    procedure FormShow(Sender: TObject);
    procedure cbHashQuestClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtSementeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtMaxSenhaExit(Sender: TObject);
  private
    function HashMd5(const Valor, Semente: string): string;
    function SenhaHasheada: string;
    function GerarSenha(const ALength: Integer; const AIncluiMaius: Boolean; const AIncluiMinus: Boolean; const AIncluiNums: Boolean; const AIncluiEspecis: Boolean): string;
    procedure SenhaAleatoria;
    procedure EmbaralharSenha(var ASenha: string);
    procedure AtualizarTamanhos(const AMax: Integer);
    function ObterMaxSenha(out AMax: Integer): Boolean;
    procedure AtualizarDestaqueTipos(const AInvalido: Boolean);
    procedure AtualizarLabelTamanho(const AMax: Integer);
    FCorOriginalOpcoes: TColor;
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

function TPrincipal.HashMD5(const Valor, Semente: string): string;
var
  MD5: TIdHashMessageDigest5;
begin
  MD5 := TIdHashMessageDigest5.Create;
  try
    Result := MD5.HashStringAsHex(Semente + Valor + Semente);
  finally
    MD5.Free;
  end;

end;

procedure TPrincipal.AtualizarDestaqueTipos(const AInvalido: Boolean);
begin
  if AInvalido then
    RzPanel1.Color := $00C6C6FF
  else
    RzPanel1.Color := FCorOriginalOpcoes;
end;

procedure TPrincipal.AtualizarLabelTamanho(const AMax: Integer);
begin
  lblTamSenha.Text :=
    '{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fcharset0 Arial;}}' + #13#10 +
    '{\colortbl ;\red255\green0\blue0;}' + #13#10 +
    '{\*\generator Riched20 10.0.26100}\viewkind4\uc1 ' + #13#10 +
    '\pard\fs22\lang1046 Tamanho da senha:\fs16\par' + #13#10 +
    '\cf1\fs12 O tamanho máximo permitido é de ' + IntToStr(AMax) + ' caracteres.\cf0\fs16\par' + #13#10 +
    '}' + #13#10 + #0;
end;

procedure TPrincipal.AtualizarTamanhos(const AMax: Integer);
var
  i: Integer;
  ValorAtual: Integer;
begin
  ValorAtual := 0;
  if cbTamanhoSenha.ItemIndex >= 0 then
    TryStrToInt(cbTamanhoSenha.Items[cbTamanhoSenha.ItemIndex], ValorAtual);

  cbTamanhoSenha.Items.BeginUpdate;
  try
    cbTamanhoSenha.Items.Clear;
    for i := 1 to AMax do
      cbTamanhoSenha.Items.Add(IntToStr(i));
  finally
    cbTamanhoSenha.Items.EndUpdate;
  end;

  if (ValorAtual >= 1) and (ValorAtual <= AMax) then
    cbTamanhoSenha.ItemIndex := ValorAtual - 1
  else
    cbTamanhoSenha.ItemIndex := 0;
end;

function TPrincipal.ObterMaxSenha(out AMax: Integer): Boolean;
begin
  Result := TryStrToInt(Trim(edtMaxSenha.Text), AMax) and (AMax > 0);
  if not Result then
  begin
    ShowMessage('Informe um tamanho máximo válido para a senha.');
    edtMaxSenha.SetFocus;
  end;
end;

procedure TPrincipal.EmbaralharSenha(var ASenha: string);
var
  i: Integer;
  Index1: Integer;
  Index2: Integer;
  CharTemp: Char;
begin
  if Length(ASenha) < 2 then
    Exit;

  for i := 1 to Length(ASenha) * 3 do
  begin
    Index1 := RandomRange(1, Length(ASenha));
    Index2 := RandomRange(1, Length(ASenha));
    CharTemp := ASenha[Index1];
    ASenha[Index1] := ASenha[Index2];
    ASenha[Index2] := CharTemp;
  end;
end;

function TPrincipal.GerarSenha(const ALength: Integer; const AIncluiMaius: Boolean; const AIncluiMinus: Boolean; const AIncluiNums: Boolean; const AIncluiEspecis: Boolean): string;
const
  Mauisculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Minusculas = 'abcdefghijklmnopqrstuvwxyz';
  Numeros = '0123456789';
  Especiais = '!@#$%^&*()-+,./?[]{}<>:;';
  Ambiguos = 'O0Il1';
var
  CaracteresDisponiveis: string;
  Senha: string;
  i: Integer;
  TiposSelecionados: Integer;
  Grupos: array of string;
  GrupoIndex: Integer;

  function RandomChar(const AChars: string): Char;
  begin
    Result := AChars[RandomRange(1, Length(AChars))];
  end;

  function FiltrarAmbiguos(const AChars: string): string;
  var
    Ch: Char;
  begin
    Result := '';
    for Ch in AChars do
      if Pos(Ch, Ambiguos) = 0 then
        Result := Result + Ch;
  end;

  procedure AdicionarGrupo(const AGrupo: string);
  var
    GrupoFiltrado: string;
  begin
    GrupoFiltrado := AGrupo;
    if cbEvitarAmbiguos.Checked then
      GrupoFiltrado := FiltrarAmbiguos(GrupoFiltrado);
    if GrupoFiltrado = '' then
      Exit;
    SetLength(Grupos, Length(Grupos) + 1);
    Grupos[High(Grupos)] := GrupoFiltrado;
    CaracteresDisponiveis := CaracteresDisponiveis + GrupoFiltrado;
    Inc(TiposSelecionados);
  end;
begin
  CaracteresDisponiveis := '';
  Senha := '';
  TiposSelecionados := 0;
  SetLength(Grupos, 0);
  AtualizarDestaqueTipos(False);

  if AIncluiMaius then
    AdicionarGrupo(Mauisculas);
  if AIncluiMinus then
    AdicionarGrupo(Minusculas);
  if AIncluiNums then
    AdicionarGrupo(Numeros);
  if AIncluiEspecis then
    AdicionarGrupo(Especiais);

  if CaracteresDisponiveis = '' then
  begin
    ShowMessage('Nenhum caractere disponível com as opções selecionadas.');
    Result := '';
    Exit;
  end;
  if ALength < 1 then
  begin
    ShowMessage('Por favor, selecione um tamanho de senha válido.');
    Result := '';
    Exit;
  end;
  if ALength < TiposSelecionados then
  begin
    AtualizarDestaqueTipos(True);
    ShowMessage('O tamanho da senha precisa ser maior ou igual ao número de tipos selecionados.');
    Result := '';
    Exit;
  end;

  for GrupoIndex := 0 to High(Grupos) do
    Senha := Senha + RandomChar(Grupos[GrupoIndex]);

  for i := Length(Senha) + 1 to ALength do
    Senha := Senha + RandomChar(CaracteresDisponiveis);

  EmbaralharSenha(Senha);

  Result := Senha;
end;

function TPrincipal.SenhaHasheada: string;
var
  Senha, Semente, SenhaGerada: string;
  Stamp: string;
begin
  Senha := Trim(edtSenha.Text);
  Semente := Trim(edtSemente.Text);

  if (Senha = '') or (Semente = '') then
  begin
    if Senha = '' then
      edtSenha.SetFocus
    else
      edtSemente.SetFocus;
    ShowMessage('Por favor, preencha a Senha e a Semente para gerar!');
    Result := '';
    Exit;
  end;

  SenhaGerada := HashMd5(Senha, Semente);
  Result := SenhaGerada;
  Stamp := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
  memSenhaGerada.Lines.Add(Format('%s - %s', [Stamp, SenhaGerada]));
  edtSenha.Clear;
  edtSemente.Clear;
  memSenhaGerada.ReadOnly := False;

  if cbCopiarAuto.Checked then
  begin
    Clipboard.AsText := SenhaGerada;
    ShowMessage('A senha foi copiada para a área de transferência!');
  end
  else
    ShowMessage('A senha foi gerada com sucesso!');
end;

procedure TPrincipal.SenhaAleatoria;
var
  TamanhoSenha: Integer;
  SenhaGerada: string;
  TamanhoMaximoSenha: Integer;
  Stamp: string;
begin
  if not ObterMaxSenha(TamanhoMaximoSenha) then
    Exit;

  if cbTamanhoSenha.ItemIndex < 0 then
  begin
    ShowMessage('Por favor, selecione um tamanho para a senha.');
    Exit;
  end;

  if not TryStrToInt(cbTamanhoSenha.Items[cbTamanhoSenha.ItemIndex], TamanhoSenha) then
  begin
    ShowMessage('Erro ao obter o tamanho da senha selecionada.');
    Exit;
  end;

  if TamanhoSenha > TamanhoMaximoSenha then
  begin
    ShowMessage('O comprimento máximo da senha permitido é de ' + IntToStr(TamanhoMaximoSenha) + ' caracteres.');
    Exit;
  end;

  SenhaGerada := GerarSenha(TamanhoSenha, cbMaius.Checked, cbMinus.Checked, cbNums.Checked, cbEspecis.Checked);
  if SenhaGerada = '' then
    Exit;

  Stamp := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
  memSenhaGerada.Lines.Add(Format('%s - %s', [Stamp, SenhaGerada]));
  if cbCopiarAuto.Checked then
  begin
    Clipboard.AsText := SenhaGerada;
    ShowMessage('A senha foi gerada e copiada para a área de transferência!');
  end
  else
    ShowMessage('A senha foi gerada com sucesso!');
end;

procedure TPrincipal.btnGerarClick(Sender: TObject);
begin
  if cbHashQuest.Checked then
  begin
    SenhaHasheada;
    Exit;
  end;

  SenhaAleatoria;
  memSenhaGerada.SetFocus;
end;

procedure TPrincipal.cbHashQuestClick(Sender: TObject);
begin
  if cbHashQuest.Checked then
  begin
    pnlHash.Visible := True;
    edtSenha.SetFocus;
    cbNums.Enabled := False;
    cbMaius.Enabled := False;
    cbMinus.Enabled := False;
    cbEspecis.Enabled := False;
    cbEvitarAmbiguos.Enabled := False;
    cbCopiarAuto.Enabled := False;
    cbTamanhoSenha.Enabled := False;
    edtMaxSenha.Enabled := False;
  end
  else
  begin
    pnlHash.Visible := False;
    btnGerar.SetFocus;
    cbNums.Enabled := True;
    cbMaius.Enabled := True;
    cbMinus.Enabled := True;
    cbEspecis.Enabled := True;
    cbEvitarAmbiguos.Enabled := True;
    cbCopiarAuto.Enabled := True;
    cbTamanhoSenha.Enabled := True;
    edtMaxSenha.Enabled := True;
  end;
  AtualizarDestaqueTipos(False);
  memSenhaGerada.Clear;
end;

procedure TPrincipal.edtSementeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnGerar.Click;
  end;
end;

procedure TPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Perform(CM_DIALOGKEY, VK_TAB, 0);
    Key := #0;
  end;
end;

procedure TPrincipal.FormShow(Sender: TObject);
const
  TamanhoMaximoPadrao = 30;
begin
  Randomize;
  FCorOriginalOpcoes := RzPanel1.Color;
  edtMaxSenha.Text := IntToStr(TamanhoMaximoPadrao);
  AtualizarTamanhos(TamanhoMaximoPadrao);
  AtualizarLabelTamanho(TamanhoMaximoPadrao);
  cbCopiarAuto.Checked := True;
  pnlHash.Visible := False;
//  Principal.Caption := 'Gerador de Senhas [ ' +  + ' ] '
end;

procedure TPrincipal.edtMaxSenhaExit(Sender: TObject);
var
  TamanhoMaximoSenha: Integer;
begin
  if ObterMaxSenha(TamanhoMaximoSenha) then
  begin
    AtualizarTamanhos(TamanhoMaximoSenha);
    AtualizarLabelTamanho(TamanhoMaximoSenha);
  end;
end;

end.
