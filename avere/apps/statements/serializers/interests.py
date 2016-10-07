# coding=utf-8
from rest_framework import serializers

from .wealth import PublicServantSerializer


class ShareholderOrNgoMemberSerializer(serializers.Serializer):
    organization = serializers.CharField(label='Unitatea: denumirea și adresa',
                                         max_length=255)
    role = serializers.CharField(label='Calitatea deținută', max_length=255)
    shares = serializers.IntegerField(label='Nr. de părți sociale sau de '
                                            'acțiuni',
                                      min_value=0)
    shares_value = serializers.IntegerField(label='Valoarea totală a părților '
                                                  'sociale și/sau a '
                                                  'acțiunilor',
                                            min_value=0)


class LeadershipPositionSerializer(serializers.Serializer):
    organization = serializers.CharField(label='Unitatea: denumirea și adresa',
                                         max_length=255)
    role = serializers.CharField(label='Calitatea deținută', max_length=255)
    remuneration = serializers.IntegerField(label='Valorea beneficiilor',
                                            min_value=0)


class ProfessionalOrgMembershipSerializer(serializers.Serializer):
    role = serializers.CharField(max_length=255)


class PoliticalMembershipSerializer(serializers.Serializer):
    role = serializers.CharField(max_length=255)


class ContractSerializer(serializers.Serializer):
    BENEFICIARY_ROLE_CHOICES = (
        (1, 'Titular'),
        (2, 'Soț/soție'),
        (3, 'Rude de gradul 1'),
        (4, 'Societăți/asociații'),
    )
    beneficiary = serializers.CharField(label='Beneficiarul de contract: '
                                              'numele, prenumele/denumirea și '
                                              'adresa')
    beneficiary_role = serializers.ChoiceField(choices=BENEFICIARY_ROLE_CHOICES)
    client = serializers.CharField(label='Instituția contractantă: denumirea '
                                         'și adresa',
                                       max_length=255)
    contract_award_method = serializers.CharField(label='Procedura prin care a '
                                                        'fost încredințat '
                                                        'contractul',
                                                max_length=255)
    contract_type = serializers.CharField(label='Tipul contractului',
                                          max_length=255)
    contract_sign_date = serializers.DateField(label='Data încheierii '
                                                     'contractului',
                                               input_formats=['%d-%m-%Y'])
    contract_duration = serializers.CharField(label='Durata contractului',
                                              max_length=255)
    contract_value = serializers.IntegerField(label='Valoarea totală a '
                                                    'contractului',
                                              min_value=0)


class InterestsStatementSerializer(serializers.Serializer):
    date = serializers.DateField(label='Data declarației',
                                 input_formats=['%d-%m-%Y'])
    public_servant = PublicServantSerializer()
    shareholder_positions = ShareholderOrNgoMemberSerializer(many=True)
    leadership_positions = LeadershipPositionSerializer(many=True)
    professional_memberships = ProfessionalOrgMembershipSerializer(many=True)
    political_memberships = PoliticalMembershipSerializer(many=True)
    contracts = ContractSerializer(many=True)
