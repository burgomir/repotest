import uuid
import psycopg2
from datetime import datetime

username = 'denterukorn'
amount = 150000000

DB_NAME = 'bee_verse'
DB_HOST = 'localhost'
DB_USERNAME = 'postgres'
DB_PASSWORD = 'Kekcik123!'

conn = psycopg2.connect(
    dbname=DB_NAME, user=DB_USERNAME, password=DB_PASSWORD, host=DB_HOST
)
cursor = conn.cursor()

def update_balance(username, amount):
    cursor.execute("SELECT id FROM players WHERE user_name = %s", (username,))
    player_id = cursor.fetchone()
    if not player_id:
        raise Exception("Player not found")

    cursor.execute(
        "UPDATE players SET balance = balance + %s, honey_latest = %s WHERE id = %s",
        (amount, amount, player_id)
    )

    cursor.execute(
        "INSERT INTO profit (id, player_id, profit, profit_type) VALUES (%s, %s, %s, %s)",
        (str(uuid.uuid4()), player_id, amount, 'click',)
    )

    # Calculate profit and check rank updates
    calculate_profit(player_id, amount)

    conn.commit()

def calculate_profit(player_id, amount):
    if amount == 0:
        return

    cursor.execute(
        "SELECT id, progress FROM player_progress WHERE player_id = %s AND type = 'Rank'",
        (player_id,)
    )
    progress = cursor.fetchone()

    if progress:
        progress_id, current_progress = progress
        cursor.execute(
            "UPDATE player_progress SET progress = progress + %s WHERE id = %s",
            (amount, progress_id)
        )
    else:
        cursor.execute(
            "INSERT INTO player_progress (id, player_id, progress, type) VALUES (%s, %s, %s, 'Rank') RETURNING id",
            (str(uuid.uuid4()), player_id, amount)
        )
        progress_id = cursor.fetchone()[0]

    check_rank_update(player_id)

def check_rank_update(player_id):
    cursor.execute(
        "SELECT id, progress FROM player_progress WHERE player_id = %s AND type = 'Rank'",
        (player_id,)
    )
    progress = cursor.fetchone()

    progress_id, current_progress = progress

    cursor.execute("SELECT id, rank, required_amount, bonus_amount FROM ranks ORDER BY rank ASC")
    ranks = cursor.fetchall()

    for rank in ranks:
        rank_id, rank_level, required_amount, bonus_amount = rank
        if current_progress >= required_amount:
            cursor.execute(
                "SELECT id FROM player_ranks WHERE player_id = %s AND rank_id = %s",
                (player_id, rank_id)
            )
            has_achieved_rank = cursor.fetchone()

            if not has_achieved_rank:
                current_progress -= required_amount

                cursor.execute(
                    "INSERT INTO player_rank_profit (id, player_id, rank_id, profit, is_collected) VALUES (%s, %s, %s, %s, %s)",
                    (str(uuid.uuid4()), player_id, rank_id, bonus_amount, False)
                )
                cursor.execute(
                    "INSERT INTO player_ranks (id, player_id, rank_id, achieved_at) VALUES (%s, %s, %s, %s)",
                    (str(uuid.uuid4()), player_id, rank_id, datetime.now())
                )

    cursor.execute(
        "UPDATE player_progress SET progress = %s WHERE id = %s",
        (current_progress, progress_id)
    )
    conn.commit()

try:
    update_balance(username, amount)
except Exception as e:
    print(e)
finally:
    cursor.close()
    conn.close()
