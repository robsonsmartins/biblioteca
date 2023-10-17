{******************************************************************************

  SISTEMA BIBLIOTECA - FBAI 2001-2002

  unit_Protecao.pas

  Sistema de Proteção para o Sistema Biblioteca.

  Desenvolvido por Robson S. Martins
  Data última revisão: 15/04/2002

*****************************************************************************}

unit unit_Protecao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, filectrl, Math, ComCtrls, ExtCtrls, Buttons, Db, ADODB;

type
  Tform_Protecao = class(TForm)
    pgc_Passos: TPageControl;
    tab_Passo3: TTabSheet;
    tab_Passo2: TTabSheet;
    pnl_Buttons: TPanel;
    tab_Passo1: TTabSheet;
    btn_Next: TBitBtn;
    btn_Cancel: TBitBtn;
    qry_Prot: TADOQuery;
    tab_Passo4: TTabSheet;
    pnl_Passo1: TPanel;
    img_Passo1: TImage;
    img_BackAll: TImage;
    lbl_ExplicaPasso1: TLabel;
    lbl_TituloPasso1: TLabel;
    lbl_ProxPasso1: TLabel;
    pnl_Passo2: TPanel;
    lbl_ProxPasso2: TLabel;
    lbl_Unidade: TLabel;
    cbx_Drive: TComboBox;
    lbl_InsiraCD: TLabel;
    lbl_TituloPasso2: TLabel;
    img_Passo2: TImage;
    pnl_Passo3: TPanel;
    img_Passo3: TImage;
    lbl_TituloPasso3: TLabel;
    lbl_ExplicaPasso3: TLabel;
    lbl_CapSerialHD: TLabel;
    lbl_CapSerialCD: TLabel;
    lbl_SerialHD: TLabel;
    lbl_SerialCD: TLabel;
    lbl_CapChave: TLabel;
    edt_Chave: TEdit;
    lbl_ProxPasso3: TLabel;
    pnl_Passo4: TPanel;
    lbl_ProxPasso4: TLabel;
    lbl_ExplicaPasso4: TLabel;
    lbl_TituloPasso4: TLabel;
    img_Passo4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btn_NextClick(Sender: TObject);
  private
    { Private declarations }
    SerialHD, SerialCD: String;
    Tentativas: Byte;
  public
    { Public declarations }
  end;

const
  DiasExpira = 31;

var
  form_Protecao: Tform_Protecao;

function BBtecaIsActive(Conn: TADOConnection): Boolean;

function HexToCardinal(Hex: String): Cardinal;
function GetSerial(Drive: String; NomeVolume: Boolean = False): String;
function ConsisteChave(Serial, Chave: String): Boolean;
function GeraChave(Serial: String): String;
function BBtCDIsValid(sDrive: String): Boolean;

implementation

{$R *.DFM}

const
  Table:  Array [0..255] of DWord =
   ($00000000, $77073096, $EE0E612C, $990951BA,
    $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
    $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
    $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
    $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172,
    $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
    $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116,
    $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
    $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,

    $76DC4190, $01DB7106, $98D220BC, $EFD5102A,
    $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818,
    $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E,
    $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
    $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
    $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
    $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086,
    $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
    $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,

    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
    $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
    $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
    $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
    $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252,
    $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60,
    $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
    $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
    $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,

    $9B64C2B0, $EC63F226, $756AA39C, $026D930A,
    $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
    $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
    $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
    $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
    $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
    $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
    $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
    $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);


function BBtecaIsActive(Conn: TADOConnection): Boolean;
type TProt = record
       SerialHD: String;
       Acesso, Inst: TDateTime;
     end;
var AppDrive, AppDriveSerial: String;
    ProtReg: TProt;
    FaltaDias: Integer;
begin
  Result := True;
  form_Protecao := Tform_Protecao.Create(nil);
  with form_Protecao, qry_Prot, ProtReg do
  begin
    Close;
    Connection := Conn;
    SQL.Text := 'SELECT * FROM PROT';
    try
      Open;
    except
      Close;
      SQL.Text := 'CREATE TABLE PROT (SERIALHD TEXT(40), INST DATE, ACESSO DATE)';
      ExecSQL;
      SQL.Text := 'SELECT * FROM PROT';
      Open;
      Insert;
      FieldByName('SERIALHD').AsString := '';
      FieldByName('INST').AsDateTime := Now;
      FieldByName('ACESSO').AsDateTime := 0;
      Post;
      Close;
      Open;
    end;
    SerialHD := FieldByName('SERIALHD').AsString;
    Acesso := FieldByName('ACESSO').AsDateTime;
    Inst := FieldByName('INST').AsDateTime;
    Close;
    AppDrive := IncludeTrailingBackslash(ExtractFileDrive(Application.ExeName));
    AppDriveSerial := GetSerial(AppDrive);
    if AppDriveSerial <> SerialHD then
    begin
      if (Acesso <> 0) and (Now < Acesso) then
      begin
        with Application do
          MessageBox('O calendário/relógio do Windows foi atrasado.',
                     'Erro Fatal',MB_OK + MB_ICONSTOP);
        Halt(1);
      end;
      SQL.Text := 'SELECT * FROM PROT';
      Open;
      Edit;
      FieldByName('ACESSO').AsDateTime := Now;
      Post;
      Close;
      FaltaDias := Trunc((Inst + DiasExpira) - Now);
      Caption := 'Ativação do Sistema Biblioteca:    ';
      if FaltaDias > 1 then
        Caption :=
          Caption + 'Faltam ' + IntToStr(FaltaDias) + ' dias para expirar a cópia'
      else if FaltaDias = 1 then
        Caption :=
          Caption + 'Falta ' + IntToStr(FaltaDias) + ' dia para expirar a cópia'
      else if FaltaDias = -1 then
        Caption :=
          Caption + 'A cópia expirou há ' + IntToStr(Abs(FaltaDias)) + ' dia'
      else if FaltaDias < -1 then
        Caption :=
          Caption + 'A cópia expirou há ' + IntToStr(Abs(FaltaDias)) + ' dias'
      else
        Caption :=
          Caption + 'A cópia expirou hoje.';
      if FaltaDias < 0 then
        FaltaDias := 0;
      if (ShowModal = mrOK) then
      begin
        SQL.Text := 'SELECT * FROM PROT';
        Open;
        Edit;
        FieldByName('SERIALHD').AsString := AppDriveSerial;
        Post;
        Close;
      end
      else if FaltaDias > 0 then
        Result := True
      else
        Result := False;
    end;
    Free;
  end;
end;

function GeraEConsisteChave(Buffer: String; crc: Cardinal = 0): Cardinal;
var i: DWord;
    q: ^Byte;
begin
  {buffer}
  if crc <> 0 then
  begin
    for i := 0 to 3 do
      Buffer := Buffer + Chr((crc and ($FF shl (i * 8))) shr (i * 8));
  end;
  q := Pointer(PChar(Buffer));
  Result := 0;
  for i := 1 to Length(Buffer) do
  begin
    Result := (Result shr 8) xor Table[q^ xor (Result and $000000FF)];
    Inc(q);
  end;
end;

function HexToCardinal(Hex: String): Cardinal;
var i: Integer;
    Num: Byte;
begin
  Result := 0;
  for i := 1 to Length(Hex) do
  begin
    if Hex[i] in ['A'..'F'] then
      Num := Ord(Hex[i]) - 55
    else
    begin
      try
        Num := StrToInt(Hex[i]);
      except
        Num := 20;
      end;
    end;
    Result := Result + Num * Round(Power(16,Length(Hex) - i));
  end;
end;

function GetSerial(Drive: String; NomeVolume: Boolean = False): String;
var RootVol: PChar;
    VolMCL, VolFSF, VolNameSize: Cardinal;
    VolSerial: DWord;
    VolName, VolNameHex: String;
    i, j: Integer;
begin
  RootVol := PChar(IncludeTrailingBackslash(Drive));
  VolNameSize := 40;
  VolName := StringOfChar('@',VolNameSize);
  GetVolumeInformation(RootVol,PChar(VolName),VolNameSize,@VolSerial,
                       VolMCL,VolFSF,nil,0);
  if NomeVolume then
  begin
    while Pos('@',VolName) <> 0 do
      System.Delete(VolName,Pos('@',VolName),1);
    Result := UpperCase(Copy(VolName,1,Length(VolName) - 1));
  end
  else
  begin
    VolNameHex := '';
    for i := 1 to 5 do
      for j := 1 to 2 do
        VolNameHex := VolNameHex + IntToStr(Ord(IntToHex(Ord(VolName[i]),2)[j]));
    Result := IntToStr(VolSerial) + VolNameHex;
    for i := 1 to 5 do
      System.Insert('-',Result,i * 6);
  end;
end;

function ConsisteChave(Serial, Chave: String): Boolean;
var ChaveH: String;
    i: Integer;
begin
  Result := True;
  while Pos('-',Serial) <> 0 do
    System.Delete(Serial,Pos('-',Serial),1);
  while Pos('-',Chave) <> 0 do
    System.Delete(Chave,Pos('-',Chave),1);
  ChaveH := '';
  if Length(Chave) mod 2 <> 0 then
    Chave := Chave + 'K';
  for i := 1 to Length(Chave) do
    if Ord(Chave[i]) > 51 then
      if i mod 2 = 0 then
        Chave[i] := Chr(Ord(Chave[i]) - (16 + i))
      else
        Chave[i] := Chr(Ord(Chave[i]) - (12 + i))
    else
      Chave[i] := Chr(Ord(Chave[i]));
  for i := 1 to Length(Chave) div 2 do
  begin
    try
      ChaveH := ChaveH + Chr(StrToInt(Chave[i + (i - 1)] + Chave[i + (i - 1) + 1]));
    except
      Result := False;
    end;
  end;
  Result := Result and (GeraEConsisteChave(Serial,HexToCardinal(ChaveH)) = 0);
end;

function GeraChave(Serial: String): String;
var ChaveH,Chave: String;
    i: Integer;
begin
  while Pos('-',Serial) <> 0 do
    System.Delete(Serial,Pos('-',Serial),1);
  ChaveH := IntToHex(GeraEConsisteChave(Serial),8);
  Chave := '';
  for i := 1 to 8 do
    Chave := Chave + IntToStr(Ord(ChaveH[i]));
  for i := 1 to Length(Chave) do
    if Ord(Chave[i]) > 51 then
      if i mod 2 = 0 then
        Chave[i] := Chr(Ord(Chave[i]) + 16 + i)
      else
        Chave[i] := Chr(Ord(Chave[i]) + 12 + i)
    else
      Chave[i] := Chr(Ord(Chave[i]));
  for i := 1 to 3 do
    System.Insert('-',Chave,i * 5);
  Result := Chave;
end;

function BBtCDIsValid(sDrive: String): Boolean;
var DriveNo: Integer;

begin
  sDrive := IncludeTrailingBackslash(sDrive);
  DriveNo := Ord(UpCase(sDrive[1])) - 64;
  Result := DiskFree(DriveNo) > 0;
  if Result then
    Result := Result and (GetSerial(sDrive,True) = 'BIBLIOTECA');
end;

procedure Tform_Protecao.FormCreate(Sender: TObject);
var i: Integer;
begin
  with pgc_Passos do
  begin
    for i := 0 to PageCount - 1 do
      Pages[i].TabVisible := False;
    ActivePage := tab_Passo1;
  end;
  SerialHD := GetSerial(ExtractFileDrive(Application.ExeName));
  lbl_SerialHD.Caption := SerialHD;
  cbx_Drive.ItemIndex := 3;
end;

procedure Tform_Protecao.btn_NextClick(Sender: TObject);
var GotoNext: Boolean;
begin
  with pgc_Passos do
  begin
    GotoNext := True;
    case pgc_Passos.ActivePageIndex of
      1: begin
           with cbx_Drive do
           begin
             GotoNext := BBtCDIsValid(Items[ItemIndex]);
             if GotoNext then
             begin
               SerialCD := GetSerial(Items[ItemIndex]);
               lbl_SerialCD.Caption := SerialCD;
               Tentativas := 0;
             end
             else
             begin
               with Application do
                 MessageBox(PChar('O CD Original do Sistema Biblioteca não foi' +
                                  ' encontrado. Insira o CD na unidade e ' +
                                  'especifique a letra de unidade corretamente.'),
                            'CD original não encontrado',MB_OK + MB_ICONWARNING);
             end;
           end;
         end;
      2: begin
           if not ConsisteChave(SerialHD + SerialCD,edt_Chave.Text) then
           begin
             GotoNext := False;
             inc(Tentativas);
             if Tentativas < 3 then
             begin
               with Application do
                 MessageBox('A chave de ativação é inválida. Tente novamente.',
                            'Chave de Ativação inválida',MB_OK + MB_ICONWARNING);
                 edt_Chave.Text := '';
                 edt_Chave.SetFocus;
             end
             else {ntentativas esgotado}
             begin
               with Application do
                 MessageBox('Número de tentativas esgotado. O Sistema Biblioteca não será ativado.',
                            'Chave de Ativação inválida',MB_OK + MB_ICONSTOP);
               ModalResult := mrCancel;
             end;
           end
           else
           begin
             GotoNext := True;
             btn_Next.Caption := 'C&oncluir';
           end;
         end;
      3: begin
           ModalResult := mrOK;
         end;
      else GotoNext := True;
    end;
    if GotoNext and (ActivePageIndex < PageCount - 1) then
    begin
      ActivePageIndex := ActivePageIndex + 1;
      case ActivePageIndex of
        0: img_BackAll.Parent := pnl_Passo1;
        1: img_BackAll.Parent := pnl_Passo2;
        2: img_BackAll.Parent := pnl_Passo3;
        3: img_BackAll.Parent := pnl_Passo4;
      end;
      img_BackAll.SendToBack;
    end;
  end;
end;

end.


