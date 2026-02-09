unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.IniFiles, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Clipbrd,
  Vcl.ComCtrls, System.Math, System.Hash, cxControls, cxContainer, cxEdit,
  cxLabel, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxComboBox,
  cxTextEdit, cxPC, RzEdit, RzPanel, RzRadGrp, RzButton, RzRadChk, RzLabel,
  RzCmboBx;
type
  TPrincipal = class(TForm)
    AdvPanel1: TPanel;
    AdvPanel2: TPanel;
    AdvLabel1: TcxLabel;
    lblTamSenha: TcxLabel;
    cbMaius: TRzCheckBox;
    RzPanel1: TRzPanel;
    cbMinus: TRzCheckBox;
    cbNums: TRzCheckBox;
    cbEspecis: TRzCheckBox;
    cbEvitarAmbiguos: TRzCheckBox;
    cbCopiarAuto: TRzCheckBox;
    cbRegistrarHistorico: TRzCheckBox;
    cbMostrarSenha: TRzCheckBox;
    btnGerar: TButton;
    btnExportar: TButton;
    btnLimparHistorico: TButton;
    btnCopiarHistorico: TButton;
    cbHashQuest: TRzCheckBox;
    pnlHash: TRzPanel;
    RzLabel1: TRzLabel;
    edtSemente: TRzEdit;
    lblMaxSenha: TRzLabel;
    edtMaxSenha: TRzEdit;
    cbTamanhoSenha: TRzComboBox;
    lblQuantidade: TRzLabel;
    edtQuantidade: TRzEdit;
    lblMinimo: TRzLabel;
    edtMinimo: TRzEdit;
    cbReqMaius: TRzCheckBox;
    cbReqMinus: TRzCheckBox;
    cbReqNums: TRzCheckBox;
    cbReqEspecis: TRzCheckBox;
    edtSenha: TRzEdit;
    RzLabel2: TRzLabel;
    AdvLabel3: TcxLabel;
    memSenhaGerada: TMemo;
    lblForca: TRzLabel;
    pbForca: TProgressBar;
    lblForcaDetalhe: TRzLabel;
    edtAmbiguos: TRzEdit;
    lblAmbiguos: TRzLabel;
    lblHashAlg: TRzLabel;
    cbHashAlg: TcxComboBox;
    lblAviso: TcxLabel;
    tmrClipboard: TTimer;
    dlgSalvarHistorico: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure cbHashQuestClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtSementeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtMaxSenhaExit(Sender: TObject);
    procedure btnLimparHistoricoClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure cbOpcoesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrClipboardTimer(Sender: TObject);
    procedure cbEvitarAmbiguosClick(Sender: TObject);
    procedure cbMostrarSenhaClick(Sender: TObject);
    procedure btnCopiarHistoricoClick(Sender: TObject);
  private
    function HashSenha(const Valor, Semente: string): string;
    function SenhaHasheada: string;
    function GerarSenha(const ALength: Integer; const AIncluiMaius: Boolean; const AIncluiMinus: Boolean; const AIncluiNums: Boolean; const AIncluiEspecis: Boolean): string;
    procedure SenhaAleatoria;
    procedure EmbaralharSenha(var ASenha: string);
    procedure AtualizarTamanhos(const AMax: Integer);
    function ObterMaxSenha(out AMax: Integer): Boolean;
    procedure AtualizarDestaqueTipos(const AInvalido: Boolean);
    procedure AtualizarLabelTamanho(const AMax: Integer);
    procedure AtualizarEstadoGerar;
    procedure AtualizarForcaSenha(const ASenha: string);
    procedure RegistrarHistorico(const ASenha: string);
    procedure CopiarSenha(const ASenha: string; const AExibirMensagem: Boolean = True);
    procedure CarregarPreferencias;
    procedure SalvarPreferencias;
    function ObterAmbiguos: string;
    function ObterNomeArquivoConfig: string;
    procedure AtualizarAmbiguosEstado;
    procedure AtualizarAvisoHash;
    function ObterQuantidade(out AQuantidade: Integer): Boolean;
    function ObterMinimo(out AMinimo: Integer): Boolean;
    procedure AtualizarAviso(const AMensagem: string);
    function ExtrairSenhaLinha(const ALinha: string): string;
    procedure ExportarHistorico(const AArquivo: string);
    function GerarBytesAleatorios(const ATamanho: Integer; out ABytes: TBytes): Boolean;
    function RandomIndexSeguro(const AMaximo: Integer): Integer;
    FCorOriginalOpcoes: TColor;
    FClipboardSnapshot: string;
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

function TPrincipal.HashSenha(const Valor, Semente: string): string;
var
  ValorComSemente: string;
begin
  ValorComSemente := Semente + Valor + Semente;
  case cbHashAlg.ItemIndex of
    0: Result := THashMD5.GetHashString(ValorComSemente);
    1: Result := THashSHA1.GetHashString(ValorComSemente);
    2: Result := THashSHA2.GetHashString(ValorComSemente, SHA256);
    3: Result := THashSHA2.GetHashString(ValorComSemente, SHA512);
  else
    Result := THashMD5.GetHashString(ValorComSemente);
  end;
end;

function TPrincipal.GerarBytesAleatorios(const ATamanho: Integer; out ABytes: TBytes): Boolean;
const
  BCRYPT_USE_SYSTEM_PREFERRED_RNG = $00000002;
type
  NTSTATUS = LongInt;
  TBCryptGenRandom = function(hAlgorithm: Pointer; pbBuffer: PByte; cbBuffer: Cardinal; dwFlags: Cardinal): NTSTATUS; stdcall;
var
  BCryptGenRandomFunc: TBCryptGenRandom;
  LibHandle: HMODULE;
begin
  Result := False;
  SetLength(ABytes, ATamanho);
  if ATamanho <= 0 then
    Exit;

  LibHandle := LoadLibrary('bcrypt.dll');
  if LibHandle = 0 then
    Exit;
  try
    @BCryptGenRandomFunc := GetProcAddress(LibHandle, 'BCryptGenRandom');
    if Assigned(BCryptGenRandomFunc) then
      Result := BCryptGenRandomFunc(nil, @ABytes[0], ATamanho, BCRYPT_USE_SYSTEM_PREFERRED_RNG) = 0;
  finally
    FreeLibrary(LibHandle);
  end;
end;

function TPrincipal.RandomIndexSeguro(const AMaximo: Integer): Integer;
var
  Bytes: TBytes;
  Valor: Cardinal;
begin
  if AMaximo <= 1 then
    Exit(0);

  if GerarBytesAleatorios(SizeOf(Valor), Bytes) then
  begin
    Move(Bytes[0], Valor, SizeOf(Valor));
    Result := Integer(Valor mod Cardinal(AMaximo));
  end
  else
    Result := Random(AMaximo);
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
  lblTamSenha.Caption := Format('Tamanho da senha:'#13#10'O tamanho máximo permitido é de %d caracteres.', [AMax]);
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

function TPrincipal.ObterQuantidade(out AQuantidade: Integer): Boolean;
begin
  Result := TryStrToInt(Trim(edtQuantidade.Text), AQuantidade) and (AQuantidade > 0) and (AQuantidade <= 100);
  if not Result then
  begin
    ShowMessage('Informe uma quantidade válida (1 a 100).');
    edtQuantidade.SetFocus;
  end;
end;

function TPrincipal.ObterMinimo(out AMinimo: Integer): Boolean;
begin
  Result := TryStrToInt(Trim(edtMinimo.Text), AMinimo) and (AMinimo >= 1);
  if not Result then
  begin
    ShowMessage('Informe um tamanho mínimo válido.');
    edtMinimo.SetFocus;
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
    Index1 := RandomIndexSeguro(Length(ASenha)) + 1;
    Index2 := RandomIndexSeguro(Length(ASenha)) + 1;
    CharTemp := ASenha[Index1];
    ASenha[Index1] := ASenha[Index2];
    ASenha[Index2] := CharTemp;
  end;
end;

function TPrincipal.ObterAmbiguos: string;
begin
  Result := Trim(edtAmbiguos.Text);
  if Result = '' then
    Result := 'O0Il1S5B8G6';
end;

function TPrincipal.GerarSenha(const ALength: Integer; const AIncluiMaius: Boolean; const AIncluiMinus: Boolean; const AIncluiNums: Boolean; const AIncluiEspecis: Boolean): string;
const
  Mauisculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Minusculas = 'abcdefghijklmnopqrstuvwxyz';
  Numeros = '0123456789';
  Especiais = '!@#$%^&*()-+,./?[]{}<>:;';
var
  CaracteresDisponiveis: string;
  Senha: string;
  i: Integer;
  TiposSelecionados: Integer;
  Grupos: array of string;
  GrupoIndex: Integer;
  Ambiguos: string;

  function RandomChar(const AChars: string): Char;
  begin
    Result := AChars[RandomIndexSeguro(Length(AChars)) + 1];
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
  Ambiguos := ObterAmbiguos;
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

  SenhaGerada := HashSenha(Senha, Semente);
  Result := SenhaGerada;
  RegistrarHistorico(SenhaGerada);
  edtSenha.Clear;
  edtSemente.Clear;
  memSenhaGerada.ReadOnly := False;

  CopiarSenha(SenhaGerada);
  AtualizarForcaSenha('');
end;

procedure TPrincipal.SenhaAleatoria;
var
  TamanhoSenha: Integer;
  SenhaGerada: string;
  TamanhoMaximoSenha: Integer;
  Quantidade: Integer;
  Minimo: Integer;
  i: Integer;
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

  if not ObterQuantidade(Quantidade) then
    Exit;

  if not ObterMinimo(Minimo) then
    Exit;

  if TamanhoSenha < Minimo then
  begin
    ShowMessage('O tamanho selecionado deve ser maior ou igual ao mínimo informado.');
    Exit;
  end;

  if cbReqMaius.Checked and not cbMaius.Checked then
  begin
    ShowMessage('Para exigir letras maiúsculas, a opção "Incluir Letras Maiúsculas" precisa estar marcada.');
    Exit;
  end;
  if cbReqMinus.Checked and not cbMinus.Checked then
  begin
    ShowMessage('Para exigir letras minúsculas, a opção "Incluir Letras Minúsculas" precisa estar marcada.');
    Exit;
  end;
  if cbReqNums.Checked and not cbNums.Checked then
  begin
    ShowMessage('Para exigir números, a opção "Incluir Números" precisa estar marcada.');
    Exit;
  end;
  if cbReqEspecis.Checked and not cbEspecis.Checked then
  begin
    ShowMessage('Para exigir especiais, a opção "Incluir Caracteres Especiais" precisa estar marcada.');
    Exit;
  end;

  SenhaGerada := '';
  for i := 1 to Quantidade do
  begin
    SenhaGerada := GerarSenha(TamanhoSenha, cbMaius.Checked, cbMinus.Checked, cbNums.Checked, cbEspecis.Checked);
    if SenhaGerada = '' then
      Exit;
    RegistrarHistorico(SenhaGerada);
  end;

  CopiarSenha(SenhaGerada, Quantidade = 1);
  AtualizarForcaSenha(SenhaGerada);
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
    cbRegistrarHistorico.Enabled := False;
    cbTamanhoSenha.Enabled := False;
    edtMaxSenha.Enabled := False;
    edtQuantidade.Enabled := False;
    edtMinimo.Enabled := False;
    cbReqMaius.Enabled := False;
    cbReqMinus.Enabled := False;
    cbReqNums.Enabled := False;
    cbReqEspecis.Enabled := False;
    AtualizarAvisoHash;
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
    cbRegistrarHistorico.Enabled := True;
    cbTamanhoSenha.Enabled := True;
    edtMaxSenha.Enabled := True;
    edtQuantidade.Enabled := True;
    edtMinimo.Enabled := True;
    cbReqMaius.Enabled := True;
    cbReqMinus.Enabled := True;
    cbReqNums.Enabled := True;
    cbReqEspecis.Enabled := True;
  end;
  AtualizarDestaqueTipos(False);
  AtualizarAmbiguosEstado;
  AtualizarEstadoGerar;
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
  cbRegistrarHistorico.Checked := True;
  pnlHash.Visible := False;
  pbForca.Min := 0;
  pbForca.Max := 100;
  pbForca.Position := 0;
  lblForca.Caption := 'Força: -';
  lblForcaDetalhe.Caption := '';
  cbHashAlg.ItemIndex := 0;
  edtAmbiguos.Text := 'O0Il1S5B8G6';
  edtQuantidade.Text := '1';
  edtMinimo.Text := '8';
  edtSenha.PasswordChar := '*';
  CarregarPreferencias;
  AtualizarAmbiguosEstado;
  AtualizarEstadoGerar;
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
  AtualizarEstadoGerar;
end;

procedure TPrincipal.RegistrarHistorico(const ASenha: string);
var
  Stamp: string;
begin
  if not cbRegistrarHistorico.Checked then
    Exit;
  Stamp := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
  memSenhaGerada.Lines.Add(Format('%s - %s', [Stamp, ASenha]));
end;

procedure TPrincipal.CopiarSenha(const ASenha: string; const AExibirMensagem: Boolean);
begin
  if not cbCopiarAuto.Checked then
  begin
    if AExibirMensagem then
      ShowMessage('A senha foi gerada com sucesso!');
    Exit;
  end;

  Clipboard.AsText := ASenha;
  FClipboardSnapshot := ASenha;
  tmrClipboard.Enabled := True;
  if AExibirMensagem then
    ShowMessage('A senha foi copiada para a área de transferência!');
end;

procedure TPrincipal.AtualizarEstadoGerar;
var
  OpcoesSelecionadas: Boolean;
begin
  if cbHashQuest.Checked then
  begin
    btnGerar.Enabled := (Trim(edtSenha.Text) <> '') and (Trim(edtSemente.Text) <> '');
    if btnGerar.Enabled then
      AtualizarAviso('')
    else
      AtualizarAviso('Preencha Senha e Semente para gerar a hash.');
    Exit;
  end;

  OpcoesSelecionadas := cbMaius.Checked or cbMinus.Checked or cbNums.Checked or cbEspecis.Checked;
  btnGerar.Enabled := OpcoesSelecionadas;
  if not OpcoesSelecionadas then
  begin
    AtualizarDestaqueTipos(True)
    AtualizarAviso('Selecione ao menos um tipo de caractere para gerar a senha.')
  end
  else
  begin
    AtualizarDestaqueTipos(False);
    AtualizarAviso('');
  end;
end;

procedure TPrincipal.AtualizarForcaSenha(const ASenha: string);
var
  Pontuacao: Integer;
  Diversidade: Integer;
  TemMaius: Boolean;
  TemMinus: Boolean;
  TemNums: Boolean;
  TemEspeciais: Boolean;
  Ch: Char;
  Recomenda: string;
begin
  if ASenha = '' then
  begin
    pbForca.Position := 0;
    lblForca.Caption := 'Força: n/a';
    lblForcaDetalhe.Caption := 'A força não se aplica para hashes.';
    Exit;
  end;

  TemMaius := False;
  TemMinus := False;
  TemNums := False;
  TemEspeciais := False;

  for Ch in ASenha do
  begin
    if Ch in ['A'..'Z'] then
      TemMaius := True
    else if Ch in ['a'..'z'] then
      TemMinus := True
    else if Ch in ['0'..'9'] then
      TemNums := True
    else
      TemEspeciais := True;
  end;

  Pontuacao := Min(100, Length(ASenha) * 5);
  Diversidade := 0;
  if TemMaius then
    Inc(Diversidade);
  if TemMinus then
    Inc(Diversidade);
  if TemNums then
    Inc(Diversidade);
  if TemEspeciais then
    Inc(Diversidade);
  Pontuacao := Min(100, Pontuacao + (Diversidade * 10));
  pbForca.Position := Pontuacao;

  if Pontuacao < 40 then
    lblForca.Caption := 'Força: fraca'
  else if Pontuacao < 70 then
    lblForca.Caption := 'Força: média'
  else
    lblForca.Caption := 'Força: forte';

  Recomenda := '';
  if Length(ASenha) < 12 then
    Recomenda := 'Considere usar 12+ caracteres. ';
  if not TemMaius then
    Recomenda := Recomenda + 'Adicione maiúsculas. ';
  if not TemMinus then
    Recomenda := Recomenda + 'Adicione minúsculas. ';
  if not TemNums then
    Recomenda := Recomenda + 'Adicione números. ';
  if not TemEspeciais then
    Recomenda := Recomenda + 'Adicione especiais.';
  lblForcaDetalhe.Caption := Trim(Recomenda);
end;

procedure TPrincipal.btnLimparHistoricoClick(Sender: TObject);
begin
  memSenhaGerada.Clear;
end;

procedure TPrincipal.btnExportarClick(Sender: TObject);
begin
  if memSenhaGerada.Lines.Count = 0 then
  begin
    ShowMessage('Não há histórico para exportar.');
    Exit;
  end;

  if dlgSalvarHistorico.Execute then
    ExportarHistorico(dlgSalvarHistorico.FileName);
end;

procedure TPrincipal.cbOpcoesClick(Sender: TObject);
begin
  AtualizarEstadoGerar;
  AtualizarAmbiguosEstado;
end;

procedure TPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SalvarPreferencias;
end;

procedure TPrincipal.tmrClipboardTimer(Sender: TObject);
begin
  tmrClipboard.Enabled := False;
  if Clipboard.AsText = FClipboardSnapshot then
    Clipboard.Clear;
end;

procedure TPrincipal.cbEvitarAmbiguosClick(Sender: TObject);
begin
  AtualizarAmbiguosEstado;
  AtualizarEstadoGerar;
end;

procedure TPrincipal.cbMostrarSenhaClick(Sender: TObject);
begin
  if cbMostrarSenha.Checked then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

procedure TPrincipal.btnCopiarHistoricoClick(Sender: TObject);
var
  Linha: string;
begin
  if memSenhaGerada.SelLength > 0 then
    Linha := memSenhaGerada.SelText
  else if memSenhaGerada.Lines.Count > 0 then
    Linha := memSenhaGerada.Lines[memSenhaGerada.Lines.Count - 1]
  else
    Linha := '';

  Linha := Trim(Linha);
  if Linha = '' then
  begin
    ShowMessage('Não há histórico para copiar.');
    Exit;
  end;

  Clipboard.AsText := ExtrairSenhaLinha(Linha);
  ShowMessage('Senha copiada do histórico.');
end;

procedure TPrincipal.AtualizarAmbiguosEstado;
begin
  edtAmbiguos.Enabled := cbEvitarAmbiguos.Checked;
  lblAmbiguos.Enabled := cbEvitarAmbiguos.Checked;
end;

procedure TPrincipal.AtualizarAvisoHash;
begin
  AdvLabel3.Caption := 'Gera uma hash da senha digitada com semente.' + sLineBreak +
    'Selecione o algoritmo de hash desejado.';
end;

procedure TPrincipal.AtualizarAviso(const AMensagem: string);
begin
  lblAviso.Caption := AMensagem;
  lblAviso.Visible := Trim(AMensagem) <> '';
end;

function TPrincipal.ExtrairSenhaLinha(const ALinha: string): string;
var
  Separador: Integer;
begin
  Separador := Pos(' - ', ALinha);
  if Separador > 0 then
    Result := Copy(ALinha, Separador + 3, MaxInt)
  else
    Result := ALinha;
end;

procedure TPrincipal.ExportarHistorico(const AArquivo: string);
var
  Extensao: string;
  Linhas: TStringList;
  i: Integer;
  Linha: string;
  Senha: string;
  DataHora: string;
  Separador: Integer;
begin
  Extensao := LowerCase(ExtractFileExt(AArquivo));
  Linhas := TStringList.Create;
  try
    if Extensao = '.csv' then
    begin
      Linhas.Add('data_hora,senha');
      for i := 0 to memSenhaGerada.Lines.Count - 1 do
      begin
        Linha := memSenhaGerada.Lines[i];
        Separador := Pos(' - ', Linha);
        if Separador > 0 then
        begin
          DataHora := Trim(Copy(Linha, 1, Separador - 1));
          Senha := Copy(Linha, Separador + 3, MaxInt);
        end
        else
        begin
          DataHora := '';
          Senha := Linha;
        end;
        Linhas.Add(Format('"%s","%s"', [StringReplace(DataHora, '"', '""', [rfReplaceAll]), StringReplace(Senha, '"', '""', [rfReplaceAll])]));
      end;
      Linhas.SaveToFile(AArquivo);
      Exit;
    end;

    if Extensao = '.json' then
    begin
      Linhas.Add('[');
      for i := 0 to memSenhaGerada.Lines.Count - 1 do
      begin
        Linha := memSenhaGerada.Lines[i];
        Separador := Pos(' - ', Linha);
        if Separador > 0 then
        begin
          DataHora := Trim(Copy(Linha, 1, Separador - 1));
          Senha := Copy(Linha, Separador + 3, MaxInt);
        end
        else
        begin
          DataHora := '';
          Senha := Linha;
        end;
        Linhas.Add(Format('  {"data_hora": "%s", "senha": "%s"}%s', [
          StringReplace(DataHora, '"', '\"', [rfReplaceAll]),
          StringReplace(Senha, '"', '\"', [rfReplaceAll]),
          IfThen(i < memSenhaGerada.Lines.Count - 1, ',', '')
        ]));
      end;
      Linhas.Add(']');
      Linhas.SaveToFile(AArquivo);
      Exit;
    end;

    memSenhaGerada.Lines.SaveToFile(AArquivo);
  finally
    Linhas.Free;
  end;
end;

function TPrincipal.ObterNomeArquivoConfig: string;
begin
  Result := IncludeTrailingPathDelimiter(GetEnvironmentVariable('APPDATA')) + 'GeradorDeSenhas.ini';
end;

procedure TPrincipal.CarregarPreferencias;
var
  Ini: TIniFile;
  Maximo: Integer;
  TamanhoSelecionado: Integer;
begin
  Ini := TIniFile.Create(ObterNomeArquivoConfig);
  try
    cbMaius.Checked := Ini.ReadBool('Opcoes', 'Maiusculas', cbMaius.Checked);
    cbMinus.Checked := Ini.ReadBool('Opcoes', 'Minusculas', cbMinus.Checked);
    cbNums.Checked := Ini.ReadBool('Opcoes', 'Numeros', cbNums.Checked);
    cbEspecis.Checked := Ini.ReadBool('Opcoes', 'Especiais', cbEspecis.Checked);
    cbEvitarAmbiguos.Checked := Ini.ReadBool('Opcoes', 'EvitarAmbiguos', cbEvitarAmbiguos.Checked);
    cbCopiarAuto.Checked := Ini.ReadBool('Opcoes', 'CopiarAuto', cbCopiarAuto.Checked);
    cbRegistrarHistorico.Checked := Ini.ReadBool('Opcoes', 'RegistrarHistorico', cbRegistrarHistorico.Checked);
    cbReqMaius.Checked := Ini.ReadBool('Opcoes', 'ReqMaiusculas', cbReqMaius.Checked);
    cbReqMinus.Checked := Ini.ReadBool('Opcoes', 'ReqMinusculas', cbReqMinus.Checked);
    cbReqNums.Checked := Ini.ReadBool('Opcoes', 'ReqNumeros', cbReqNums.Checked);
    cbReqEspecis.Checked := Ini.ReadBool('Opcoes', 'ReqEspeciais', cbReqEspecis.Checked);
    edtAmbiguos.Text := Ini.ReadString('Opcoes', 'Ambiguos', edtAmbiguos.Text);
    Maximo := Ini.ReadInteger('Opcoes', 'Maximo', 30);
    edtMaxSenha.Text := IntToStr(Maximo);
    AtualizarTamanhos(Maximo);
    AtualizarLabelTamanho(Maximo);
    cbHashAlg.ItemIndex := Ini.ReadInteger('Opcoes', 'HashAlg', cbHashAlg.ItemIndex);
    if cbHashAlg.ItemIndex < 0 then
      cbHashAlg.ItemIndex := 0;
    TamanhoSelecionado := Ini.ReadInteger('Opcoes', 'Tamanho', cbTamanhoSenha.ItemIndex + 1);
    if (TamanhoSelecionado > 0) and (TamanhoSelecionado <= cbTamanhoSenha.Items.Count) then
      cbTamanhoSenha.ItemIndex := TamanhoSelecionado - 1;
    edtQuantidade.Text := Ini.ReadString('Opcoes', 'Quantidade', edtQuantidade.Text);
    edtMinimo.Text := Ini.ReadString('Opcoes', 'Minimo', edtMinimo.Text);
  finally
    Ini.Free;
  end;
end;

procedure TPrincipal.SalvarPreferencias;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ObterNomeArquivoConfig);
  try
    Ini.WriteBool('Opcoes', 'Maiusculas', cbMaius.Checked);
    Ini.WriteBool('Opcoes', 'Minusculas', cbMinus.Checked);
    Ini.WriteBool('Opcoes', 'Numeros', cbNums.Checked);
    Ini.WriteBool('Opcoes', 'Especiais', cbEspecis.Checked);
    Ini.WriteBool('Opcoes', 'EvitarAmbiguos', cbEvitarAmbiguos.Checked);
    Ini.WriteBool('Opcoes', 'CopiarAuto', cbCopiarAuto.Checked);
    Ini.WriteBool('Opcoes', 'RegistrarHistorico', cbRegistrarHistorico.Checked);
    Ini.WriteBool('Opcoes', 'ReqMaiusculas', cbReqMaius.Checked);
    Ini.WriteBool('Opcoes', 'ReqMinusculas', cbReqMinus.Checked);
    Ini.WriteBool('Opcoes', 'ReqNumeros', cbReqNums.Checked);
    Ini.WriteBool('Opcoes', 'ReqEspeciais', cbReqEspecis.Checked);
    Ini.WriteString('Opcoes', 'Ambiguos', edtAmbiguos.Text);
    Ini.WriteInteger('Opcoes', 'Maximo', StrToIntDef(edtMaxSenha.Text, 30));
    Ini.WriteInteger('Opcoes', 'HashAlg', cbHashAlg.ItemIndex);
    Ini.WriteInteger('Opcoes', 'Tamanho', cbTamanhoSenha.ItemIndex + 1);
    Ini.WriteString('Opcoes', 'Quantidade', edtQuantidade.Text);
    Ini.WriteString('Opcoes', 'Minimo', edtMinimo.Text);
  finally
    Ini.Free;
  end;
end;

end.
