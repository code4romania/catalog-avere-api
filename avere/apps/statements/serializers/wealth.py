# coding=utf-8
from rest_framework import serializers


class PublicServantSerializer(serializers.Serializer):
    first_name = serializers.CharField(label='Prenume', max_length=255)
    last_name = serializers.CharField(label='Nume', max_length=255)
    position = serializers.CharField(label='Funcție', max_length=255)
    position_location = serializers.CharField(label='Locul funcției',
                                              max_length=255)


# I. Bunuri imobile
class LandSerializer(serializers.Serializer):
    CATEGORY_CHOICES = (
        (1, 'agricol'),
        (2, 'forestier'),
        (3, 'intravilan'),
        (4, 'luciu apă'),
        (5, 'alte categorii de terenuri extravilane, dacă se află în '
            'circuitul civil'),
    )
    location = serializers.CharField(label='Adresa sau zona', max_length=255)
    category = serializers.ChoiceField(label='Categoria',
                                       choices=CATEGORY_CHOICES)
    year_acquired = serializers.DateField(label='Anul dobândirii',
                                          input_formats=['%Y'])
    area = serializers.IntegerField(label='Suprafața (mp)')
    share = serializers.IntegerField(label='Cota-parte (%)', min_value=0,
                                     max_value=100)
    method_acquired = serializers.CharField(label='Modul de dobândire',
                                            max_length=255)
    owner = serializers.CharField(label='Titularul', max_length=255)


class BuildingSerializer(serializers.Serializer):
    CATEGORY_CHOICES = (
        (1, 'apartament'),
        (2, 'casă de locuit'),
        (3, 'casă de vacanță'),
        (4, 'spații comerciale/de producție'),
    )
    location = serializers.CharField(label='Adresa sau zona', max_length=255)
    category = serializers.ChoiceField(label='Categoria',
                                       choices=CATEGORY_CHOICES)
    year_acquired = serializers.DateField(label='Anul dobândirii',
                                          input_formats=['%Y'])
    area = serializers.IntegerField(label='Suprafața (mp')
    share = serializers.IntegerField(label='Cota-parte (%)', min_value=0,
                                     max_value=100)
    method_acquired = serializers.CharField(label='Modul de dobândire',
                                            max_length=255)
    owner = serializers.CharField(label='Titularul', max_length=255)


# II. Bunuri mobile
class VehicleSerializer(serializers.Serializer):
    kind = serializers.CharField(label='Natura', max_length=255)
    brand = serializers.CharField(label='Marca', max_length=255)
    count = serializers.IntegerField(label='Nr. de bucăți', min_value=0)
    year_made = serializers.DateField(label='Anul fabricației',
                                      input_formats=['%Y'])
    method_acquired = serializers.CharField(label='Modul de dobândire',
                                            max_length=255)


class PreciousItemSerializer(serializers.Serializer):
    description = serializers.CharField(label='Descriere sumară',
                                        max_length=255)
    year_acquired = serializers.DateField(label='Anul dobândirii',
                                          input_formats=['%Y'])
    estimated_value = serializers.IntegerField(label='Valoarea estimată',
                                               min_value=0)

# III. Bunuri înstrăinate
class EstrangedGoodSerializer(serializers.Serializer):
    kind = serializers.CharField(label='Natura bunului înstrăinat',
                                 max_length=255)
    date_estranged = serializers.DateField(label='Data înstrăinării')
    estranged_to = serializers.CharField(label='Persoana către care s-a '
                                               'înstrăinat',
                                         max_length=255)
    procedure = serializers.CharField(label='Forma înstrăinării',
                                      max_length=255)
    value = serializers.IntegerField(label='Valoarea', min_value=0)


# IV. Active financiare
class BankAccountSerializer(serializers.Serializer):
    KIND_CHOICES = (
        (1, 'cont curent sau echivalente (inclusiv card)'),
        (2, 'depozit bancar sau echivalente'),
        (3, 'fonduri de investiții sau echivalente, inclusiv fonduri private '
            'de pensii sau alte sisteme de acumulare')
    )
    institution = serializers.CharField(label='Instituția care administrează '
                                              'și adresa acesteia',
                                        max_length=255)
    kind = serializers.ChoiceField(label='Tipul', choices=KIND_CHOICES)
    currency = serializers.CharField(label='Valuta', max_length=3)
    year_opened = serializers.DateField(label='Deschis în anul',
                                        input_formats=['%Y'])
    value = serializers.IntegerField(label='Sold/valoare la zi', min_value=0)


class PlacementSerializer(serializers.Serializer):
    KIND_CHOICES = (
        (1, 'hârtii de valoare deținute (titluri de stat, certificate, '
            'obligațiuni'),
        (2, 'acțiuni sau părți sociale în societăți comerciale'),
        (3, 'împrumuturi acordate în nume personal')
    )
    target = serializers.CharField(label='Emitent titlu/societatea în care '
                                         'persoana e acționar/beneficiar de '
                                         'împrumut', max_length=255)
    kind = serializers.ChoiceField(label='Tipul', choices=KIND_CHOICES)


# V. Datorii
class DebtSerializer(serializers.Serializer):
    creditor = serializers.CharField(label='Creditor', max_length=255)
    year_contracted = serializers.DateField(label='Contractat în anul',
                                            input_formats=['%Y'])
    due = serializers.DateField(label='Scadent la')
    value = serializers.IntegerField(label='Valoare', min_value=0)


# VI. Cadouri & VII. Venituri
class PresentIncomeSerializer(serializers.Serializer):
    EARNER_ROLE_CHOICES = (
        (1, 'Titular'),
        (2, 'Soț/soție'),
        (3, 'Copil'),
    )
    INCOME_CURRENCY_CHOICES = (
        (1, 'RON'),
        (2, 'EUR'),
        (3, 'USD'),
    )
    earner = serializers.CharField(label='Cine a realizat venitul')
    earner_role = serializers.ChoiceField(choices=EARNER_ROLE_CHOICES)
    giver = serializers.CharField(label='Sursa venitului: nume, adresa',
                                  max_length=255)
    service = serializers.CharField(label='Serviciul prestat/Obiectul '
                                          'generator  de venit',
                                    max_length=255)
    anual_income = serializers.IntegerField(label='Venitul anual încasat',
                                            min_value=0)
    income_currency = serializers.ChoiceField(label='Valuta',
                                              choices=INCOME_CURRENCY_CHOICES)


class WealthStatementSerializer(serializers.Serializer):
    date = serializers.DateField(label='Data declarației',
                                 input_formats=['%d-%m-%Y'])
    public_servant = PublicServantSerializer()
    lands = LandSerializer(many=True)
    buildings = BuildingSerializer(many=True)
    vehicles = VehicleSerializer(many=True)
    precious_items = PreciousItemSerializer(many=True)
    estranged_goods = EstrangedGoodSerializer(many=True)
    bank_accounts = BankAccountSerializer(many=True)
    placements = PlacementSerializer(many=True)
    debts = DebtSerializer(many=True)
    presents = PresentIncomeSerializer(many=True)
    sources_of_income = PresentIncomeSerializer(many=True)
