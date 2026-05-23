# 🏠 Airbnb Analytics — Rio de Janeiro

Pipeline de dados completo com análise do mercado de aluguéis de curta temporada no Rio de Janeiro, utilizando dados públicos do [Inside Airbnb](https://insideairbnb.com/).

---

## 🎯 Objetivo

Transformar dados brutos do Airbnb em insights acionáveis sobre ocupação, precificação e sazonalidade do mercado carioca, seguindo boas práticas de engenharia de dados.

---

## 🛠️ Stack Tecnológico

| Ferramenta | Uso |
|---|---|
| **BigQuery** | Data Warehouse — armazenamento e processamento dos dados |
| **dbt Cloud** | Transformação, modelagem e testes de qualidade |
| **Power BI** | Visualização e dashboards |
| **GitHub** | Versionamento do código |

---

## 📐 Arquitetura do Pipeline

```
Inside Airbnb (CSV)
        ↓
  BigQuery Raw
  (airbnb_raw)
        ↓
   Staging Layer
  ┌─────────────────┐
  │  stg_listings   │  → limpeza, tipagem e filtros
  │  stg_calendar   │  → padronização de campos
  └─────────────────┘
        ↓
 Intermediate Layer
  ┌─────────────────┐
  │  int_listings   │  → categorização de preço e tamanho
  │  int_calendar   │  → métricas de ocupação e receita
  └─────────────────┘
        ↓
    Marts Layer
  ┌──────────────────────┐
  │  mart_listings_full  │  → tabela principal (listing + ocupação)
  │  mart_seasonality    │  → sazonalidade por mês e bairro
  │  mart_listings_summary│ → resumo por bairro e tipo de quarto
  └──────────────────────┘
        ↓
     Power BI
   (Dashboards)
```

---

## 📊 Modelos dbt

### Staging
- **`stg_listings`** — dados de imóveis limpos e tipados, com filtro de preços nulos/inválidos
- **`stg_calendar`** — disponibilidade e preço por dia de cada listing

### Intermediate
- **`int_listings`** — adiciona categorização de preço (`low/medium/high`) e capacidade (`small/medium/large`)
- **`int_calendar`** — calcula `revenue_realized`, `revenue_potential`, `is_booked` e flag de fim de semana

### Marts
- **`mart_listings_full`** — tabela desnormalizada com características do imóvel + métricas de ocupação e receita; base principal do Power BI
- **`mart_seasonality`** — análise de sazonalidade por ano, mês, bairro e tipo de quarto
- **`mart_listings_summary`** — agregado por bairro e tipo de quarto com preço médio e avaliações

---

## 📈 Análises Disponíveis

- **Ocupação** — taxa de ocupação (`occupancy_rate`) por listing, bairro e período
- **Receita** — `revenue_realized`, `revpar` (receita por dia disponível)
- **Sazonalidade** — variação de preço e ocupação ao longo dos meses (Carnaval, Réveillon, etc.)
- **Precificação** — distribuição de preços por bairro, tipo de quarto e capacidade
- **Superhosts** — comparativo de avaliações e ocupação entre superhosts e hosts comuns

---

## ✅ Qualidade de Dados

Testes implementados com dbt:

- `unique` e `not_null` nos campos-chave
- `accepted_values` para `room_type`
- Filtro de listings sem preço definido na camada de staging

---

## 📁 Estrutura do Repositório

```
airbnb-dbt/
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── schema.yml
│   │   ├── stg_listings.sql
│   │   └── stg_calendar.sql
│   ├── intermediate/
│   │   ├── int_listings.sql
│   │   └── int_calendar.sql
│   └── marts/
│       ├── schema.yml
│       ├── mart_listings_full.sql
│       ├── mart_listings_summary.sql
│       ├── mart_calendar.sql
│       └── mart_seasonality.sql
├── analyses/
├── macros/
├── seeds/
└── dbt_project.yml
```

---

## 🚀 Como Reproduzir

### Pré-requisitos
- Conta no [dbt Cloud](https://cloud.getdbt.com/)
- Projeto no [Google BigQuery](https://cloud.google.com/bigquery)
- Dados do [Inside Airbnb — Rio de Janeiro](https://insideairbnb.com/get-the-data/)

### Passos
1. Faça upload dos arquivos `listings.csv` e `calendar.csv` no BigQuery (dataset: `airbnb_raw`)
2. Clone este repositório e conecte ao dbt Cloud
3. Configure o `profiles.yml` com suas credenciais do BigQuery
4. Execute o pipeline completo:

```bash
dbt build
```

---

## 📌 Fonte dos Dados

Dados públicos disponibilizados pelo [Inside Airbnb](https://insideairbnb.com/get-the-data/), coletados da plataforma Airbnb para a cidade do **Rio de Janeiro, Brasil**.

---

## 👤 Autor

**Diego Diez Garcia**  
[GitHub](https://github.com/diegodzgarcia) 
