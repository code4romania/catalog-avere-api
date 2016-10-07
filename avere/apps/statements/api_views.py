from rest_framework.generics import CreateAPIView

from statements.models import InterestsStatement, WealthStatement
from statements.serializers import (InterestsStatementSerializer,
                                    WealthStatementSerializer)


class WealthStatementCreateAPIView(CreateAPIView):
    serializer_class = WealthStatementSerializer

    def perform_create(self, serializer):
        WealthStatement.objects.create(content=serializer.data)


class InterestsStatementCreateAPIView(CreateAPIView):
    serializer_class = InterestsStatementSerializer

    def perform_create(self, serializer):
        InterestsStatement.objects.create(content=serializer.data)
