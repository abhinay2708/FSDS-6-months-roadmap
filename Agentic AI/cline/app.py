import streamlit as st
from tictactoe import initialize_game, make_move, check_win, check_draw, reset_game

st.title("Tic-Tac-Toe")

# Initialize game state
initialize_game()

# Display the board
col1, col2, col3 = st.columns(3)
buttons = [
    [col1, col2, col3],
    [st.columns(3)[0], st.columns(3)[1], st.columns(3)[2]],
    [st.columns(3)[0], st.columns(3)[1], st.columns(3)[2]]
]

for row in range(3):
    for col in range(3):
        if st.session_state.board[row][col] == '':
            if st.columns(3)[col].button(f" ", key=f"btn_{row}_{col}"):
                make_move(row, col)
                st.rerun() # Rerun to update the board and game state
        else:
            st.columns(3)[col].button(st.session_state.board[row][col], disabled=True, key=f"btn_{row}_{col}")

# Display game status
if st.session_state.game_over:
    if st.session_state.winner == 'Draw':
        st.warning("It's a Draw!")
    else:
        st.success(f"Player {st.session_state.winner} wins!")
else:
    st.info(f"Current Player: {st.session_state.current_player}")

# Reset button
if st.button("Reset Game"):
    reset_game()
    st.rerun()
